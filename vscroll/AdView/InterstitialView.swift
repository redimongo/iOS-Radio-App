//
//  InterstitialView.swift
//  Google AdMob Tutorial
//
//  Created by Francesco Dal Savio on 14/03/21.
//
import GoogleMobileAds
import SwiftUI
import UIKit

class InterstitialAd: NSObject {
    var interstitialAd: GADInterstitialAd?
    
    static let shared = InterstitialAd()
    
    func loadAd(withAdUnitId id: String) {
        let req = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: id, request: req) { interstitialAd, err in
            if let err = err {
                print("Failed to load ad with error: \(err.localizedDescription)")
                return
            }
            else{
            self.interstitialAd = interstitialAd
           
           
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitialAd?.present(fromRootViewController: root!)
            }
        }
    }
}

final class InterstitialAdView: NSObject, UIViewControllerRepresentable, GADFullScreenContentDelegate {
    
    let interstitialAd = InterstitialAd.shared.interstitialAd
    @Binding var isPresented: Bool
    var adUnitId = "ca-app-pub-4999865903647931/3126345304"
    
    init(isPresented: Binding<Bool>, adUnitId: String) {
        self._isPresented = isPresented
        self.adUnitId = adUnitId
        super.init()
        
        interstitialAd?.fullScreenContentDelegate = self
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.showAd(from: view)
        }
        
        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func showAd(from root: UIViewController) {
        
        if let ad = interstitialAd {
            ad.present(fromRootViewController: root)
        } else {
            print("Ad not ready")
            self.isPresented.toggle()
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
        
        isPresented.toggle()
    }
}



final class OpenAd: NSObject, GADFullScreenContentDelegate {
   var appOpenAd: GADAppOpenAd?
   var loadTime = Date()
   
   func requestAppOpenAd() {
       let request = GADRequest()
       GADAppOpenAd.load(withAdUnitID: "ca-app-pub-4999865903647931/3126345304",
                         request: request,
                         orientation: UIInterfaceOrientation.portrait,
                         completionHandler: { (appOpenAdIn, _) in
                           self.appOpenAd = appOpenAdIn
                           self.appOpenAd?.fullScreenContentDelegate = self
                           self.loadTime = Date()
                           print("[OPEN AD] Ad is ready")
         
                         })
   }
   
   func tryToPresentAd() {
       if let gOpenAd = self.appOpenAd, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
           gOpenAd.present(fromRootViewController: (UIApplication.shared.windows.first?.rootViewController)!)
       } else {
           self.requestAppOpenAd()
       }
   }
   
   func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
       let now = Date()
       let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
       let secondsPerHour = 3600.0
       let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
       return intervalInHours < Double(thresholdN)
   }
   
   func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("[OPEN AD] Failed: \(error)")
       requestAppOpenAd()
   }
   
   func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       requestAppOpenAd()
       print("[OPEN AD] Ad dismissed")
   }
   
   func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("[OPEN AD] Ad did present")
   }
}



/*final class Interstitial:NSObject{
    var interstitial:GADInterstitialAd = GADInterstitial(adUnitID: "ca-app-pub-4999865903647931/3126345304")
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(){
        if self.interstitial.isReady{
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: interstitialID)
        LoadInterstitial()
    }
}

struct ContentView:View{
    var interstitial:Interstitial
    
    init(){
        self.interstitial = Interstitial()
    }
    
    var body : some View{
      Button(action: {self.interstitial.showAd()}){
        Text("My Button")
      }
    }
}

*/
