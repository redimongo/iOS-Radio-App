//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 30/4/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK



struct WinView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var state: String{
        return "\(userSettings.state)"
    }
    var country: String{
        return "\(userSettings.country)"
    }
 
    
    var body: some View {
        NavigationView {
        GeometryReader { geo in
            VStack(alignment: .leading){
                if (state.isEmpty && country.isEmpty){
                   
                    VStack(alignment: .leading){
                        VStack{
                            Spacer().frame(maxWidth: .infinity)
                            Text("WE CAN'T LOCATE YOUR STATE & COUNTRY").font(.title).foregroundColor(.white)
                            Image(systemName: "location.fill").resizable().scaledToFit().frame(width: 100).foregroundColor(.white)
                            Text("WOW, Seems your out on a boat in the middle of the seas catching big fish, or maybe your a pirate.\n\nNext time your on land we will check to see where you are located.").foregroundColor(.white)
                          Spacer().frame(maxWidth: .infinity)
                        }
                    }
                  
                }else if (state.contains("WA") && country.contains("Australia")){
                    List {
                        Section(header: Text("Enter Now")){
                            NavigationLink(destination: AreUFunnyView()) {
                                        Image("AreUFunny").resizable().aspectRatio(contentMode: .fit)
                            }
                            
                            NavigationLink(destination: RequestSongView()) {
                                        Image("F7Request&WIN!").resizable().aspectRatio(contentMode: .fit)
                            }
                        }
                        Section(header: Text("Coming Soon")){
                            NavigationLink(destination: BattleoftheBandsView()) {
                                        Image("BattleOfTheBands").resizable().aspectRatio(contentMode: .fill)
                                                    .frame(maxWidth: .infinity)
                                                    .clipped()
                                                    
                            }
                                            
                            
                        }
                    }.padding(.trailing, -32.0).padding(.leading, -12.0)
                }else{
                    VStack(alignment: .leading){
                        VStack{
                            Spacer().frame(maxWidth: .infinity)
                            Text("OUT OF AREA").font(.title).foregroundColor(.white)
                            Image(systemName: "location.fill").resizable().scaledToFit().frame(width: 100).foregroundColor(.white)
                            Text("DRN1 is a Western Australia radio station\nAll entries must come from WA.").foregroundColor(.white)
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
        .navigationBarTitle("WIN",displayMode: .inline)
        .navigationBarHidden(false)
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
