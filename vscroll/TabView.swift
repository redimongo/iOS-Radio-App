//
//  TabView.swift
//  DRN1
//
//  Created by Russell Harrower on 2/5/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

import GoogleMobileAds

struct TaView: View {
    @StateObject var monitor = Monitor()
    @ObservedObject var location = LocationManager()
    @State var errorDetail = false
  
    
    var lat: String{
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }
    
    var lon: String{
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    
    var state: String{
        return "\(UserSettings().state)"
    }
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
            
//        print(self.data.connected)
        self.location.startUpdating()
    }
    @ObservedObject var userSettings = UserSettings()
    
    
    var body: some View {
        if (self.lat == "0.0" && self.lon == "0.0"){
            LocationDisabled()
        }
        else{
            if #available(iOS 14.0, *) {
                TabView {
                    ContentView()
                        
                        .tabItem {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("Radio")
                        }
                    
                    WinView()
                        .tabItem {
                            Image(systemName: "w.circle")
                            Text("Win")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                            
                        }
                }.accentColor(Color.red)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                                switch status {
                                case .authorized:
                                    // Tracking authorization dialog was shown
                                    // and we are authorized
                                    print("Authorized")
                                    
                                    // Now that we are authorized we can get the IDFA
                                    print(ASIdentifierManager.shared().advertisingIdentifier)
                                case .denied:
                                    // Tracking authorization dialog was
                                    // shown and permission is denied
                                    print("Denied")
                                case .notDetermined:
                                    // Tracking authorization dialog has not been shown
                                    print("Not Determined")
                                case .restricted:
                                    print("Restricted")
                                @unknown default:
                                    print("Unknown")
                                }})
                }
                .onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                        if self.monitor.score == 0{
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.errorDetail = true
                            }
                        }
                        
                        //print("this is the score \(monitor.score)")
                    }
                }
                .fullScreenCover(isPresented: self.$errorDetail, content: NetworkOutageView.init)
            } else {
            //SUpport for backward compatiblity
            }
        }
    }
}


struct LocationDisabled: View {
    @ObservedObject var location = LocationManager()

    init() {
        self.location.startUpdating()
    }
    var body: some View {
        GeometryReader { geo in
        VStack{
            Spacer().frame(maxHeight: 100)
            Image(systemName: "location.fill").resizable().scaledToFit().frame(width: 100).foregroundColor(Color.white)
           
            ScrollView {
            VStack{
                Text("Enable Location").font(.system(.largeTitle, design: .rounded)).bold().multilineTextAlignment(.leading).foregroundColor(Color.white)
                 Text("You'll need to enable your location.\nIn order to use access these features").fontWeight(.light).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding(.all, 8).foregroundColor(Color.white)
                 Text("\u{2022} Win Prizes\n\n\u{2022} Change Stations\n\n\u{2022} Access Podcasts\n\n\u{2022} Request Songs\n\n\u{2022} And More").bold().multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding(.all, 8).foregroundColor(Color.white)
                 
                
            }
            }
            VStack{
                Button(action: {
                     self.location.requestLoc()
                }) {
                    Text("ALLOW LOCATION")
                        .font(.headline)
                        .bold()
                }.buttonStyle(LocationGradientButtonStyle())
                .padding(.bottom, 100)
           }
        
        
        
       // ImageOverlay()
    }.frame(maxWidth: .infinity,maxHeight: .infinity).edgesIgnoringSafeArea(.all).background(
        Image("TooFarWallPaper").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity,maxHeight: .infinity).edgesIgnoringSafeArea(.all)
        )
    }
    }
}


struct LocationGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some SwiftUI.View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(15.0)
    }
}

struct SaveGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some SwiftUI.View {
        configuration.label
            .foregroundColor(Color.black)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
            .cornerRadius(5.0)
    }
}
