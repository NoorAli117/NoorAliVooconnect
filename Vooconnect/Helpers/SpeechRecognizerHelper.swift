import AVFoundation
import AVKit
import Foundation
import Speech
import SwiftUI
import AVPlayerViewController_Subtitles

class SpeechRecognizerHelper: ObservableObject {
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    @Published var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    private var url : URL?
    
    init() {
        recognizer = SFSpeechRecognizer()
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                print("has recognizer")
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                print("has authorization")
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
    }
    
    deinit {
        reset()
    }
    
    func transcribe(url contentUrl : URL) {
        print("start transcibing audio");
        self.url = contentUrl
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            
            do {
                let (audioEngine, request) = try Self.prepareEngine(url: contentUrl)
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }
    
    func recognizeFile(url: URL) {
       guard let myRecognizer = SFSpeechRecognizer() else {
          // A recognizer is not supported for the current locale
          return
       }
       
       if !myRecognizer.isAvailable {
          // The recognizer is not available right now
          return
       }

       let request = SFSpeechURLRecognitionRequest(url: url)
       myRecognizer.recognitionTask(with: request) { (result, error) in
          guard let result = result else {
             // Recognition failed, so check error for details and handle it
             return
          }

          // Print the speech that has been recognized so far
          if result.isFinal {
             print("Speech in the file is \(result.bestTranscription.formattedString)")
            self.transcript = result.bestTranscription.formattedString
          }
       }
    }
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    
     func recognizeSubtitles(audioUrl : URL) -> AVPlayer {
//        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//
//        recognitionRequest.shouldReportPartialResults = true
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
//            result!.bestTranscription.formattedString
//        }
        
        let vmInput = VideoMediaInput(url: audioUrl, speed: 1)
        return vmInput.player
    }
    
    func addSubtitles(videoUrl : URL, audioUrl : URL, completion: @escaping (Subtitles) -> ()){
//
        print("calling addsubs")
        do{
            let input = try Data(contentsOf: audioUrl)
            
            
            let songUrl = URL(string: audioUrl.absoluteString.replacingOccurrences(of: "out", with: "out-encoded"))
            var values = [UInt8](repeating:0, count: input.count)
            input.copyBytes(to: &values, count: input.count)
            try input.base64EncodedString().write(to: songUrl!, atomically: true, encoding: .utf8)
//            print(values)
            let parser = try Subtitles(file: songUrl!)

            // Do something with result
            let subtitles = parser.searchSubtitles(at: 2.0)
            print("subtitles1111: " + (subtitles?.description ?? "nil"))
            self.transcript = "has substitles"
            completion(parser)
        }catch(let error){
            print(error.localizedDescription)
        }
    }
    
    func addSubtitlesToPlayer(videoUrl : URL, audioUrl : URL) -> AVPlayerViewController{

        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url:videoUrl)
        let songUrl = URL(string: audioUrl.absoluteString.replacingOccurrences(of: "out", with: "out-encoded"))
        try! moviePlayer.open(fileFromLocal: songUrl!,encoding: .utf8)
        moviePlayer.addSubtitles()
//        moviePlayer.addSubtitles().open(file: audioUrl, encoding: String.Encoding.utf8)

        // Change text properties
        moviePlayer.subtitleLabel?.textColor = UIColor.red
        moviePlayer.show(subtitles: "This is a substitle")
        moviePlayer.player?.play()

        return moviePlayer
    }
    
    func getText(subtitles : Subtitles, player : AVPlayer){
        transcript = subtitles.searchSubtitles(at: player.currentTime().seconds) ?? ""
        print("subtitle" + player.currentTime().seconds.description + ": " + transcript)
    }
    
    
    func stopTranscribing() {
        reset()
    }
    
    func reset() {
        transcript = ""
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private static func prepareEngine(url : URL) throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        let audioFilePlayer: AVAudioPlayerNode = AVAudioPlayerNode()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
//        let audioSession = AVAudioSession.sharedInstance()
//        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
//        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        audioEngine.prepare()
//        try audioEngine.start()
        let audioFile = try! AVAudioFile(forReading: url)
        let audioFormat = audioFile.processingFormat
        let audioFrameCount = UInt32(audioFile.length)
        let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(audioFileBuffer!)
        }
        try! audioFile.read(into: audioFileBuffer!)

        let mainMixer = audioEngine.mainMixerNode
//        audioEngine.attachNode(audioFilePlayer)
        
        audioEngine.attach(audioFilePlayer)
        audioEngine.connect(audioFilePlayer, to:mainMixer, format: audioFileBuffer!.format)
        try audioEngine.start()
        return (audioEngine, request)
    }
    
    func getAudioFromVideoUrl(url : String, callback : @escaping (URL) -> ()) {
        // Create a composition
        let composition = AVMutableComposition()
        do {
            let asset = AVURLAsset(url: URL(string: url)!)
            guard let audioAssetTrack = asset.tracks(withMediaType: AVMediaType.audio).first else { return }
            guard let audioCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { return }
            try audioCompositionTrack.insertTimeRange(audioAssetTrack.timeRange, of: audioAssetTrack, at: CMTime.zero)
        } catch {
            print("GAFVU: "+error.localizedDescription)
        }

        // Get url for output
        let outputUrl = URL(fileURLWithPath: NSTemporaryDirectory() + "out.wav")
        if FileManager.default.fileExists(atPath: outputUrl.path) {
            try? FileManager.default.removeItem(atPath: outputUrl.path)
        }

        // Create an export session
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough)!
        exportSession.outputFileType = AVFileType.wav
        exportSession.outputURL = outputUrl

        // Export file
        exportSession.exportAsynchronously {
            guard case exportSession.status = AVAssetExportSession.Status.completed else { return }
            guard let outputURL = exportSession.outputURL else { return }
            callback(outputURL)
        }
    }
    
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }
        
        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }
    
    private func speak(_ message: String) {
        transcript = message
        print("current text from video: "+transcript)
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
        print(transcript)
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
