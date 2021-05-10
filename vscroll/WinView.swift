//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 30/4/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK
import KingfisherSwiftUI



struct WinView: View {
    @ObservedObject var userSettings = UserSettings()
    
    let string = UserSettings().state
    
    var body: some View {
        NavigationView {
        GeometryReader { geo in
            VStack(alignment: .leading){
                if string.isEmpty{
                  
                      
                    LocationDisabled()
                        
                        
                  
                }else if string.contains("WA"){
                    NavigationLink(destination: RequestSongView()) {
                        Image("F7Request&WIN!").resizable().aspectRatio(contentMode: .fit)
                    }
                }else{
                    VStack(alignment: .leading){
                        VStack{
                            Spacer().frame(maxWidth: .infinity)
                            Text("OUT OF AREA").font(.title)
                            Image(systemName: "location.fill").resizable().scaledToFit().frame(width: 100)
                            Text("DRN1 is a Western Australia radio station\nAll entries must come from WA.")
                          Spacer().frame(maxWidth: .infinity)
                        }
                        
                        
                       // ImageOverlay()
                    }.frame(
                   
                    minHeight: 0
                    ).background(
                        Image("TooFarWallPaper").resizable()
                        )
                }
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
            .onAppear{
                //Send data to dataA
                Flurry.logEvent("Win")
                //RUN CODE TO Fetch podcast episodes.
                
                
            }
         }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
        
}
