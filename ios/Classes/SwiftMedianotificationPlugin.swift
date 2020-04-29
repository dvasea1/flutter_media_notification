import Flutter
import UIKit
import Foundation
import AVFoundation
import MediaPlayer

public class SwiftMedianotificationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "medianotification", binaryMessenger: registrar.messenger())
    let instance = SwiftMedianotificationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if (call.method == "getPlatformVersion") {
               result("iOS " + UIDevice.current.systemVersion)
           }
           else if (call.method == "showAlertDialogshowAlertDialog") {
           print("test")
            setAudio()
            setupRemoteTransportControls()
            setupNowPlayingInfoPanel()
            //updateInfoPanelOnPlay()
            
           }
  }
    
    public func setAudio(){
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.playback, options: [])
            try audioSession.setActive(true)
        } catch _ { }
    }

   private var nowPlayingInfo = [String : Any]()
   
private func setupRemoteTransportControls() {

        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { event in
            return .success
            
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { event in
           return .success
           
        }
    }

    private func setupNowPlayingInfoPanel() {

        nowPlayingInfo[MPMediaItemPropertyTitle] = "self.title"

        nowPlayingInfo[MPMediaItemPropertyArtist] = "self.subtitle"

        if #available(iOS 10.0, *) {
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = false
        }

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 100

        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 200

        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0 // will be set to 1 by onTime callback
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }


   private func updateInfoPanelOnPlay() {
       
       self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 100
       self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
       
       MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
   }

 
}
