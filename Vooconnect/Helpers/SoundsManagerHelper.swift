//
//  SoundsManagerHelper.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
import AVFAudio
import AVFoundation
class SoundsManagerHelper{
    static var instance: SoundsManagerHelper = SoundsManagerHelper()
    var audioPlayer: AVPlayer?
    private var preview : String = ""
    func playAudioFromUrl(url : String) -> Bool
    {
        if(url == preview){
            pause()
            return false
        }
        print("playing audio: "+url)
        preview = url
        self.audioPlayer = AVPlayer(url:URL(string: preview)!)
        audioPlayer?.play()
        return true
    }
    
    func pause(){
        preview = ""
        audioPlayer?.pause()
    }
    
    init() {
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            print("Error AvAudioSession")
        }
    }
}
