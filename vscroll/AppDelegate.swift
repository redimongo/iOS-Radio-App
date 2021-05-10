//
//  AppDelegate.swift
//  vscroll
//
//  Created by Russell Harrower on 17/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK
import AVKit
import CarPlay


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      

        print("app launch and this is your fav station : "+UserSettings().favStation)
        
       
        switch UserSettings().favStation {
        case "DRN1":
            AdStichrApi.station = "DRN1"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1", type: "radio")
        case "DRN1 United":
            AdStichrApi.station = "DRN1United"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1United", type: "radio")
        case "DRN1 Hits":
            AdStichrApi.station = "DRN1Hits"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1Hits", type: "radio")
        case "DRN1 Life":
            AdStichrApi.station = "1lifeRadio"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/1lifeRadio", type: "radio")
        case "DRN1 Dance":
            AdStichrApi.station = "dance"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/dance", type: "radio")
        
        default:
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1", type: "radio")
        }
        
        
       // MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1", type: "radio")
        setupNotifications()
        Flurry.setUserID(UIDevice.current.identifierForVendor?.uuidString)
        switch UserSettings().gender {
            case "Male":
                Flurry.setGender("m")
            case "Female":
                Flurry.setGender("f")
            default:
                Flurry.setGender("o")
        }
        
       
        let ageComponents = Calendar.current.dateComponents([.year],
                                                from: UserSettings().dateofbirth,
                                                to: Date())
        let age = Int32(ageComponents.year!)
        Flurry.setAge(age);
        Flurry.startSession("XXXXXXXX", with: FlurrySessionBuilder
              .init()
              .withCrashReporting(true)
              .withLogLevel(FlurryLogLevelAll))
        return true
    }
    
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

      if(connectingSceneSession.role == UISceneSession.Role.carTemplateApplication) {
        let scene =  UISceneConfiguration(name: "CarPlay", sessionRole: connectingSceneSession.role)

        // At the time of writing this blog post there seems to be a bug with the info.plist file where
        // the delegateClass isn't set correctly. So we manually set it here.
        if #available(iOS 14.0, *) {
            scene.delegateClass = CarPlaySceneDelegate.self
        } else {
            // Fallback on earlier versions
        }
                
        return scene
       } else {
         let scene =  UISceneConfiguration(name: "Phone", sessionRole: connectingSceneSession.role)
                
          return scene
       }
    }

    // MARK: UISceneSession Lifecycle

  /*  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }*/

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    //CUSTOM CODE
    
    func setupNotifications() {
           // Get the default notification center instance.
           let nc = NotificationCenter.default
           nc.addObserver(self,
                          selector: #selector(handleInterruption),
                          name: AVAudioSession.interruptionNotification,
                          object: nil)
       }
       
       @objc func handleInterruption(notification: Notification) {

           guard let userInfo = notification.userInfo,
               let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
               let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeRawValue) else {
               return
           }

           switch interruptionType {
           case .began:
               print("interruption began")
           case .ended:
            MusicPlayer.shared.player?.play()
               print("interruption ended")
           default:
               print("UNKNOWN")
           }

       }

}

