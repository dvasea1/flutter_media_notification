import Flutter
import UIKit
import Foundation
import AVFoundation
import MediaPlayer

public class SwiftMedianotificationPlugin: NSObject, FlutterPlugin {
    
    static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "medianotification", binaryMessenger: registrar.messenger())
        let instance = SwiftMedianotificationPlugin()
        if let channel = channel {
            registrar.addMethodCallDelegate(instance, channel: channel)
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if (call.method == "getPlatformVersion") {
            result("iOS " + UIDevice.current.systemVersion)
        }
        else if (call.method == "show_media_notification") {
            startAudioSession()
            setupRemoteTransportControls()
            
            let parsedData = call.arguments as! [String: Any]
            
            setupNowPlayingInfoPanel(title: parsedData["title"] as! String, subtitle: parsedData["subtitle"] as! String
                , currentProgress: parsedData["currentProgress"] as! Int, totalDuration: parsedData["totalDuration"] as! Int)
        }
        else if (call.method == "hide_media_notification") {
            stopAudioSession()
        }
        else if (call.method == "change_notification_progress") {
            let parsedData = call.arguments as! [String: Any]
            updateInfoPanelOnTime(currentProgress: parsedData["currentProgress"] as! Int)
        }
        else if (call.method == "play") {
            updateInfoPanelOnPlay()
        }
        else if (call.method == "pause") {
            updateInfoPanelOnPause()
        }
    }
    
    private var nowPlayingInfo = [String : Any]()
    
    private func startAudioSession(){
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.playback, options: [])
            try audioSession.setActive(true)
        } catch _ { }
    }
    
    private func stopAudioSession(){
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(false)
        } catch _ { }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
    
    private func setupRemoteTransportControls() {
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { event in
            print("play click")
            if let channel = SwiftMedianotificationPlugin.channel {
                channel.invokeMethod("onPlay", arguments: nil)
            }
            
            return .success
            
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { event in
            print("pause click")
            if let channel = SwiftMedianotificationPlugin.channel {
                channel.invokeMethod("onPause", arguments: nil)
            }
            return .success
            
        }
    }
    
    private func setupNowPlayingInfoPanel(title: String = "", subtitle: String = "", currentProgress: Int, totalDuration: Int) {
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        
        nowPlayingInfo[MPMediaItemPropertyArtist] = subtitle
        
        if #available(iOS 10.0, *) {
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = false
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentProgress
        
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = totalDuration
        
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0 // will be set to 1 by onTime callback
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    private func updateInfoPanelOnTime(currentProgress: Int) {
        
        self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentProgress
        self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
    }
    
    private func updateInfoPanelOnPlay() {
        
        // self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentProgress
        self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
    }
    
    private func updateInfoPanelOnPause() {
        
        //self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentProgress
        self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
    }
    
    
}
