//
//  NetworkOutage.swift
//  DRN1
//
//  Created by Russell Harrower on 9/5/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
struct NetworkOutageView: View {
    @StateObject var monitor = Monitor()
    @Environment(\.presentationMode) var presentationMode
  
        var body: some View {
        GeometryReader { geo in
        VStack{
            Spacer().frame(maxHeight: 100)
            Image(systemName: "wifi.exclamationmark").resizable().scaledToFit().frame(width: 100).foregroundColor(Color.white)
            
            VStack{
                 Text("Network Outage").font(.system(.largeTitle, design: .rounded)).bold().multilineTextAlignment(.leading).foregroundColor(Color.white)
                 Text("You'll need to enable your wifi or cell network.\nIn order to use access DRN1").fontWeight(.light).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding(.all, 8).foregroundColor(Color.white)
                 
                 
                
                Spacer()
                
           }
        
        
        
       // ImageOverlay()
    }.frame(maxWidth: .infinity,maxHeight: .infinity).edgesIgnoringSafeArea(.all).background(
        Image("NetworkOutageLong").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity,maxHeight: .infinity).edgesIgnoringSafeArea(.all)
        )
    }
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                if monitor.score == 1{
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
        }
    }
}
    
    
    
    
    
    
    
    /*
    var body: some View {
    NavigationView{
              
        VStack{
                Text("Seems you have no internet connection?")
                Text("Please check your network connection")
            
                Button("Dismiss Modal") {
                       presentationMode.wrappedValue.dismiss()
                }.buttonStyle(NeumorphicButtonStyle(bgColor: .red))
        
        }
        
            
        }.navigationBarTitle("Settings", displayMode: .inline)
    .navigationViewStyle(StackNavigationViewStyle())
   }//.navigationBarTitle(Text("Settings"), displayMode: .inline)
   
   

}*/



struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}
