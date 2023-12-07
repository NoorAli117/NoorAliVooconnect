//
//  ViewController.swift
//  ARGearSample
//
//  Created by Jaecheol Kim on 2019/10/28.
//  Copyright © 2019 Seerslab. All rights reserved.
//

import UIKit
import CoreMedia
import SceneKit
import AVFoundation
import ARGear
import SwiftUI

public final class MainViewController: UIViewController {
    
    var toast_main_position = CGPoint(x: 0, y: 0)
    
    // MARK: - ARGearSDK properties
    private var argConfig: ARGConfig?
    private var argSession: ARGSession?
    private var currentFaceFrame: ARGFrame?
    private var nextFaceFrame: ARGFrame?
    private var preferences: ARGPreferences = ARGPreferences()
    
    // MARK: - Camera & Scene properties
    private let serialQueue = DispatchQueue(label: "serialQueue")
    private var currentCamera: CameraDeviceWithPosition = .front
    
    private var arCamera: ARGCamera!
    private var arScene: ARGScene!
    private var arMedia: ARGMedia = ARGMedia()
    
    private lazy var cameraPreviewCALayer = CALayer()
    
    // MARK: - Functions UI
    @IBOutlet weak var filterCancelLabel: UILabel!
    @IBOutlet weak var contentCancelLabel: UILabel!
    
    // MARK: - UI
    @IBOutlet weak var splashView: SplashView!
    @IBOutlet weak var touchLockView: UIView!
    @IBOutlet weak var permissionView: PermissionView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var ratioView: RatioView!
    @IBOutlet weak var mainTopFunctionView: MainTopFunctionView!
    @IBOutlet weak var mainBottomFunctionView: MainBottomFunctionView!
    var cameraInfoData: ((_ content: Any) -> Void)?
    var senderButton: UIButton = UIButton()
    private var argObservers = [NSKeyValueObservation]()
    var Vm : ViewModel?
    let size = UIScreen.main.bounds.size
    // MARK: - Lifecycles
    override public func viewDidLoad() {
      super.viewDidLoad()
        
        setupARGearConfig()
        setupScene()
        setupCamera()
        setupUI()
        addObservers()
        
        initHelpers()
        connectAPI()
        ratioButtonAction()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runARGSession()
        
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopARGSession()
    }

    deinit {
        removeObservers()
    }
    
    private func initHelpers() {
        ARNetworkManager.shared.argSession = self.argSession
        BeautyManager.shared.argSession = self.argSession
        FilterManager.shared.argSession = self.argSession
        ContentManager.shared.argSession = self.argSession
        BulgeManager.shared.argSession = self.argSession
        
        BeautyManager.shared.start()
    }
    
    // MARK: - connect argear API
    private func connectAPI() {
        
        ARNetworkManager.shared.connectAPI { (result: Result<[String: Any], APIError>) in
            switch result {
            case .success(let data):
                RealmManager.shared.setARGearData(data) { [weak self] success in
                    guard let self = self else { return }

                    self.loadAPIData()
                }
            case .failure(.network):
                self.loadAPIData()
                break
            case .failure(.data):
                self.loadAPIData()
                break
            case .failure(.serializeJSON):
                self.loadAPIData()
                break
            }
        }
    }
    
    private func loadAPIData() {
        DispatchQueue.main.async {
            let categories = RealmManager.shared.getCategories()
            
            self.mainBottomFunctionView.contentView.contentsCollectionView.contents = categories
            self.mainBottomFunctionView.contentView.contentTitleListScrollView.contents = categories
            self.mainBottomFunctionView.filterView.filterCollectionView.filters = RealmManager.shared.getFilters()
            
            RealmManager.shared.getDuoCategories { categories in
                print("Retrieved categories: \(categories)")
                self.Vm?.categories = categories
            }

            
        }
    }
    
    // MARK: - ARGearSDK setupConfig
    private func setupARGearConfig() {
        do {
            let config = ARGConfig(
                apiURL: API_HOST,
                apiKey: API_KEY,
                secretKey: API_SECRET_KEY,
                authKey: API_AUTH_KEY
            )
            argSession = try ARGSession(argConfig: config, feature: [.faceMeshTracking])
            argSession?.delegate = self
            
            let debugOption: ARGInferenceDebugOption = self.preferences.showLandmark ? .optionDebugFaceLandmark2D : .optionDebugNON
            argSession?.inferenceDebugOption = debugOption
            
        } catch let error as NSError {
            print("Failed to initialize ARGear Session with error: %@", error.description)
        } catch let exception as NSException {
            print("Exception to initialize ARGear Session with error: %@", exception.description)
        }
    }

    // MARK: - setupScene
    private func setupScene() {
        arScene = ARGScene(viewContainer: view)

        arScene.sceneRenderUpdateAtTimeHandler = { [weak self] renderer, time in
            guard let self = self else { return }
            self.refreshARFrame()
        }

        arScene.sceneRenderDidRenderSceneHandler = { [weak self] renderer, scene, time in
            guard let _ = self else { return }
        }

        cameraPreviewCALayer.contentsGravity = .resizeAspect//.resizeAspectFill
        cameraPreviewCALayer.frame = CGRect(x: 0, y: 0, width: arScene.sceneView.frame.size.height, height: arScene.sceneView.frame.size.width)
        cameraPreviewCALayer.contentsScale = UIScreen.main.scale
        view.layer.insertSublayer(cameraPreviewCALayer, at: 0)
    }
    
    // MARK: - setupCamera
    private func setupCamera() {
        arCamera = ARGCamera()
        
        arCamera.sampleBufferHandler = { [weak self] output, sampleBuffer, connection in
            guard let self = self else { return }
            
            self.serialQueue.async {

                self.argSession?.update(sampleBuffer, from: connection)
            }
        }
        
        self.permissionCheck {
            self.arCamera.startCamera()
            
            self.setCameraInfo()
        }
    }
    
    func setCameraInfo() {
        
        if let device = arCamera.cameraDevice, let connection = arCamera.cameraConnection {
            self.arMedia.setVideoDevice(device)
            self.arMedia.setVideoDeviceOrientation(connection.videoOrientation)
            self.arMedia.setVideoConnection(connection)
        }
        arMedia.setMediaRatio(arCamera.ratio)
        arMedia.setVideoBitrate(ARGMediaVideoBitrate(rawValue: self.preferences.videoBitrate) ?? ._4M)
    }
    
    // MARK: - UI
    private func setupUI() {

        self.mainTopFunctionView.delegate = self
        self.mainBottomFunctionView.delegate = self
        self.settingView.delegate = self
        
        self.ratioView.setRatio(arCamera.ratio)
        self.settingView.setPreferences(autoSave: self.arMedia.autoSave, showLandmark: self.preferences.showLandmark, videoBitrate: self.preferences.videoBitrate)
        
        toast_main_position = CGPoint(x: self.view.center.x, y: mainBottomFunctionView.frame.origin.y - 24.0)
        
        ARGLoading.prepare()
    }
    
    private func startUI() {
        self.setCameraInfo()
        self.touchLock(false)
    }
    
    private func pauseUI() {
        self.ratioView.blur(true)
        self.touchLock(true)
    }
    
    func refreshRatio() {
        let ratio = arCamera.ratio
        
        self.ratioView.setRatio(ratio)
        self.mainTopFunctionView.setRatio(ratio)
        
        self.setCameraPreview(ratio)
        
        self.arMedia.setMediaRatio(ratio)
    }
    
    func setCameraPreview(_ ratio: ARGMediaRatio) {
        self.cameraPreviewCALayer.contentsGravity = (ratio == ._16x9) ? .resizeAspectFill : .resizeAspect
    }
    
    // MARK: - ARGearSDK Handling
    private func refreshARFrame() {
        
        guard self.nextFaceFrame != nil && self.nextFaceFrame != self.currentFaceFrame else { return }
        self.currentFaceFrame = self.nextFaceFrame
    }
    
    private func drawARCameraPreview() {

        guard
            let frame = self.currentFaceFrame,
            let pixelBuffer = frame.renderedPixelBuffer
            else {
            return
        }
        
        var flipTransform = CGAffineTransform(scaleX: -1, y: 1)
        if self.arCamera.currentCamera == .back {
            flipTransform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.async {

            CATransaction.flush()
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            if #available(iOS 11.0, *) {
                self.cameraPreviewCALayer.contents = pixelBuffer
            } else {
                self.cameraPreviewCALayer.contents = self.pixelbufferToCGImage(pixelBuffer)
            }
            let angleTransform = CGAffineTransform(rotationAngle: .pi/2)
            let transform = angleTransform.concatenating(flipTransform)
            self.cameraPreviewCALayer.setAffineTransform(transform)
            self.cameraPreviewCALayer.frame = CGRect(x: 0, y: -self.getPreviewY(), width: (self.Vm?.cameraSize.width)!, height: (self.Vm?.cameraSize.height)!)
            self.view.backgroundColor = .white
            CATransaction.commit()
        }
    }
    
    private func getPreviewY() -> CGFloat {
        let height43: CGFloat = (self.view.frame.width * 4) / 3
        let height11: CGFloat = self.view.frame.width
        var previewY: CGFloat = 0
        if self.arCamera.ratio == ._1x1 {
            previewY = (height43 - height11)/2 + CGFloat(kRatioViewTopBottomAlign11/2)
        }
        
        if #available(iOS 11.0, *), self.arCamera.ratio != ._16x9 {
            if let topInset = UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.top {
                if self.arCamera.ratio == ._1x1 {
                    previewY += topInset/2
                } else {
                    previewY += topInset
                }
            }
        }
        
        return previewY
    }
    
    private func pixelbufferToCGImage(_ pixelbuffer: CVPixelBuffer) -> CGImage? {
        let ciimage = CIImage(cvPixelBuffer: pixelbuffer)
        let context = CIContext()
        let cgimage = context.createCGImage(ciimage, from: CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelbuffer), height: CVPixelBufferGetHeight(pixelbuffer)))

        return cgimage
    }

    private func runARGSession() {

        argSession?.run()
    }
    
    private func stopARGSession() {
        argSession?.pause()
    }
    
    func removeSplashAfter(_ sec: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            self.splashView.removeFromSuperview()
        }
    }
}

// MARK: - ARGearSDK ARGSession delegate
extension MainViewController : ARGSessionDelegate {

      public func didUpdate(_ arFrame: ARGFrame) {
        
        if let splash = self.splashView {
            splash.removeFromSuperview()
        }
        
        self.drawARCameraPreview()

        for face in arFrame.faces.faceList {
           if face.isValid {
//            NSLog("landmarkcount = %d", face.landmark.landmarkCount)
            
            // get face information (landmarkCoordinates , rotation_matrix, translation_vector)
            // let landmarkcount = face.landmark.landmarkCount
            // let landmarkCoordinates = face.landmark.landmarkCoordinates
            // let rotation_matrix = face.rotation_matrix
            // let translation_vector = face.translation_vector

           }
        }
        
        nextFaceFrame = arFrame
        
        if #available(iOS 11.0, *) {
        } else {
            self.arScene.sceneView.sceneTime += 1
        }
    }
    
}

// MARK: - User Interaction
extension MainViewController {
    // Touch Lock Control
    func touchLock(_ lock: Bool) {
        
        self.touchLockView.isHidden = !lock
        if lock {
            mainTopFunctionView.disableButtons()
        } else {
            mainTopFunctionView.enableButtons()
        }
    }
}

// MARK: - Permission
extension MainViewController {
    func permissionCheck(_ permissionCheckComplete: @escaping PermissionCheckComplete) {
        
        let permissionLevel = self.permissionView.permission.getPermissionLevel()
        self.permissionView.permission.grantedHandler = permissionCheckComplete
        self.permissionView.setPermissionLevel(permissionLevel)
        
        switch permissionLevel {
        case .Granted:
            break
        case .Restricted:
            self.removeSplashAfter(1.0)
        case .None:
            self.removeSplashAfter(1.0)
        }
    }
}

// MARK: - Observers
extension MainViewController {
    
    // MainTopFunctionView
    func addMainTopFunctionViewObservers() {
        self.argObservers.append(
            self.arCamera.observe(\.ratio, options: [.new]) { [weak self] obj, _ in
                guard let self = self else { return }

                self.mainTopFunctionView.setRatio(obj.ratio)
            }
        )
    }
    
    // MainBottomFunctionView
    func addMainBottomFunctionViewObservers() {
        self.argObservers.append(
            self.arCamera.observe(\.ratio, options: [.new]) { [weak self] obj, _ in
                guard let self = self else { return }
                
                self.mainBottomFunctionView.setRatio(obj.ratio)
            }
        )
    }
    
    // Add
    func addObservers() {
        self.addMainTopFunctionViewObservers()
        self.addMainBottomFunctionViewObservers()
    }
    
    // Remove
    func removeObservers() {
        self.argObservers.removeAll()
    }
}

// MARK: - Setting Delegate
extension MainViewController: SettingDelegate {
    func autoSaveSwitchAction(_ sender: UISwitch) {
        self.arMedia.autoSave = sender.isOn
    }
    
    func faceLandmarkSwitchAction(_ sender: UISwitch) {
        self.preferences.setShowLandmark(sender.isOn)

        if let session = self.argSession {
            let debugOption: ARGInferenceDebugOption = sender.isOn ? .optionDebugFaceLandmark2D : .optionDebugNON
            session.inferenceDebugOption = debugOption
        }
    }
    
    func bitrateSegmentedControlAction(_ sender: UISegmentedControl) {
        self.preferences.setVideoBitrate(sender.selectedSegmentIndex)
        self.arMedia.setVideoBitrate(ARGMediaVideoBitrate(rawValue: sender.selectedSegmentIndex) ?? ._4M)
    }
}

// MARK: - MainTopFunction Delegate
extension MainViewController: MainTopFunctionDelegate {
    
    func settingButtonAction() {
        self.settingView.open()
    }
    
    func ratioButtonAction() {
        guard
            let session = argSession
            else { return }

        self.pauseUI()
        session.pause()

        self.arCamera.changeCameraRatio {

            self.startUI()
            self.refreshRatio()
            session.run()
        }
    }
    
    func toggleButtonAction() {
        guard
            let session = argSession
            else { return }
        
        self.pauseUI()
        session.pause()

        arCamera.toggleCamera {

            self.startUI()
            self.refreshRatio()
            session.run()
        }
    }
}

// MARK: - MainBottomFunction Delegate
extension MainViewController: MainBottomFunctionDelegate {
    func hideBottomView(isHidden: Bool) {
        if isHidden == false{
            Vm!.bottomHide = false
        }
    }
    
    func photoButtonAction(_ button: UIButton) {
        self.arMedia.takePic { image in
            self.photoButtonActionFinished(image: image)
        }
    }
    
    
    func videoButtonAction(_ button: UIButton) {
        if senderButton.tag == 0 {
            // start record
            senderButton.tag = 1
            self.mainTopFunctionView.disableButtons()
            self.arMedia.recordVideoStart { [weak self] recTime in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    self.mainBottomFunctionView.setRecordTime(Float(recTime))
                }
            }
        } else {
            // stop record
            ARGLoading.show()
            senderButton.tag = 0
            self.mainTopFunctionView.enableButtons()
            self.arMedia.recordVideoStop({ tempFileInfo in
            }) { resultFileInfo in
                ARGLoading.hide()
                if let info = resultFileInfo as? Dictionary<String, Any> {
                    self.videoButtonActionFinished(videoInfo: info)
                }
            }
        }
    }
    
    func photoButtonActionFinished(image: UIImage?) {
        guard let saveImage = image else { return }
        
        self.arMedia.save(saveImage, saved: {
            self.view.showToast(message: "photo_video_saved_message".localized(), position: self.toast_main_position)
        }) {
            self.goPreview(content: saveImage)
        }
    }
    
    func videoButtonActionFinished(videoInfo: Dictionary<String, Any>?) {
        guard let info = videoInfo else { return }
        
        self.arMedia.saveVideo(info, saved: {
            self.view.showToast(message: "photo_video_saved_message".localized(), position: self.toast_main_position)
        }) {
            self.goPreview(content: info)
        }
    }
    
    
    func goPreview(content: Any) {
        print(content)
        cameraInfoData?(content)
    }
}



struct MainViewRepresenter: UIViewControllerRepresentable {
    @ObservedObject var Vm: ViewModel
    var cameraInfoData: ((_ content: Any) -> Void)?
    var height: Double
    func makeUIViewController(context: Context) ->  UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController {
            vc.cameraInfoData = cameraInfoData
            
            vc.Vm = Vm
            return vc
        }
        
        return UIViewController()
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let vc = uiViewController as? MainViewController {
            if Vm.cameraChannge  {
                vc.toggleButtonAction()
                Vm.cameraChannge = false
            }
            if Vm.openBeauty  {
                vc.mainBottomFunctionView.bottumButtonAction(index: 0)
                Vm.openBeauty = false
            }
            if Vm.openFilter {
                vc.mainBottomFunctionView.bottumButtonAction(index: 2)
                Vm.openFilter = false
            }
            if Vm.isVideo {
                vc.mainBottomFunctionView.modeSelectView.videoSelected()
                Vm.isVideo = false
            }
            if Vm.isPhoto {
                vc.mainBottomFunctionView.modeSelectView.pictureSelected()
                Vm.isPhoto = false
            }
            if Vm.openCategory {
                vc.mainBottomFunctionView.bottumButtonAction(index: 3)
                Vm.openCategory = false
            }
            if Vm.openBluge {
                vc.mainBottomFunctionView.bottumButtonAction(index: 1)
                Vm.openBluge = false
            }
            if Vm.isRecording {
                vc.mainBottomFunctionView.shutterButtonAction(vc.senderButton)
                Vm.isRecording = false
            }
            if Vm.selectFilter {
                vc.mainBottomFunctionView.filterView.filterCollectionView.setFilter(filter: Vm.filter, indexPath: Vm.selectedFilterIndex)
                Vm.selectFilter = false
            }
            if Vm.clearFilter {
                vc.mainBottomFunctionView.filterView.filterCollectionView.clearFilter()
                Vm.clearFilter = false
            }
            if Vm.compareBeauty {
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(vc.mainBottomFunctionView.beautyView.compareButtonLongPressAction(_:)))
                vc.mainBottomFunctionView.beautyView.compareButton.addGestureRecognizer(longPressGesture)
//                Vm.compareBeauty = false
            }
            if Vm.setBeauty{
                let slider = UISlider()
                slider.value = Float(Vm.sliderValue)
                vc.mainBottomFunctionView.beautyView.sliderValue(slider)
            }
            if Vm.selectBeauty{
                let updatedSliderValue = vc.mainBottomFunctionView.beautyView.beautyCollectionView.selectBeauty(indexPath: Vm.beautyIndexPath)
                Vm.sliderValue = updatedSliderValue
                Vm.selectBeauty = false
            }
        }
    }
}

class ViewModel: ObservableObject {
    @Published var cameraSize = CGSize(width: 0, height: 0)
    @Published var cameraChannge = false
    @Published var openFilter = false
    @Published var openBeauty = false
    @Published var openCategory = false
    @Published var openBluge = false
    @Published var isVideo = true
    @Published var isPhoto = false
    @Published var isRecording = false
    @Published var bottomHide = false
    @Published var clearFilter = false
    @Published var selectFilter = false
    @Published var compareBeauty = false
    @Published var selectBeauty = false
    @Published var setBeauty = true
    @Published var openBeautyy = false
    @Published var sliderValue = 0.0
    @Published var beautyIndex = 0
    @Published var beautyIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    @Published var selectedFilterIndex: IndexPath = IndexPath(row: 0, section: 0)
    @Published var categories = [Category]()
    @Published var filter: Item = Item()
}
