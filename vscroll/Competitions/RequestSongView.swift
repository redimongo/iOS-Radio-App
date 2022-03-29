//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 03/05/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK
//import KingfisherSwiftUI



struct RequestSongView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State private var song: String = ""
    @State private var artist: String = ""
    
    //let string = UserSettings().state
    
   
    @State var Fname = UserSettings().firstname
    @State var Flast = UserSettings().lastname
    @State var Fgender = UserSettings().gender
    @State var Fdob = UserSettings().dateofbirth
    @State var Fage = UserSettings().age
    @State var Femail = UserSettings().email
    @State private var showingAlert = false

    func SubmitForm(){
        //print(song)
        
        if(song.isEmpty || artist.isEmpty){
            showingAlert = true
        }
        else{
            userSettings.lockRequest = Date()
            print(CompForm().requestForm(Rsong: song,Rartist: artist))
        }
    }
   // let diff = Calendar.current.dateComponents([.hour], from: UserSettings().lockRequest, to: Date()).hour!
   // let diffmin = Calendar.current.dateComponents([.minute], from: UserSettings().lockRequest, to: Date()).minute!
    
    
    
    func timeString(time: TimeInterval) -> String {
        let hours = 24 - Int(time) / 3600
        let minutes = 60 - Int(time) / 60 % 60
        let seconds = 60 - Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    var body: some View {
      
        GeometryReader { geo in
            if let diff = Calendar.current.dateComponents([.hour], from: UserSettings().lockRequest, to: Date()).hour, diff > 24 {
            
                    Form {
                        VStack(alignment: .leading){
                                 Image("F7Request&WIN!").resizable().aspectRatio(contentMode: .fit)
                                
                        }
                        Section(header: Text("Your Profile")) {
                           
                                TextField("First Name", text: $userSettings.firstname)
                                    .disabled(true)
                                
                                TextField("Last Name", text: $userSettings.lastname)
                                    .disabled(true)
                                
                                TextField("Email Address", text: $userSettings.email)
                                    .disabled(true)
                            Text("This is the email address that the prize will be sent to").font(.system(size: 10))
                            
                            if Fname.isEmpty{
                                Text("To enter this competition you need to fillout your user profile.")
                                
                                NavigationLink(destination:SettingsView()) {
                                    Text("Your Profile")
                                        .frame(width: geo.size.width, height: 100, alignment: .center)
                                        .background(Color.green)
                                        .padding(-30)
                                        .foregroundColor(Color.black)
                                }
                                }
                                
                        }
                        Section(header: Text("Your Request")){
                            TextField("Song", text: $song)
                            TextField("Artist", text: $artist)
                        }
                        
                        Section(header: Text("Terms")){
                            Text("1) Entrants acknowledge that Apple is not a participant in or sponsor of this competition.\n\n2) Entrants understand an electronic giftcard will be sent to their registered Apple account.\n\n3) Radio Media Pty Ltd is not liable for the electronic giftcard once it has been sent.\n\n4) Entrants agree not to hold Radio Media Pty Ltd liable for any voucher or giftcard that does not work.\n\n5) Entrants understand that the prize can not be exchanged for cash.\n\n6) One giftcard will be randomly drawn each week, the value of that card will be random ranging from $10-$100\n\n7) Winner/s will be announced during the show\n\n7.1) Entrants must be listening to the show LIVE and ring when their name is announced, failure to call within 5 minutes of announcement will result in winner not being valid to collect prize.\n\n8) Entrants understand that their personal information will be stored on Radio Media Pty Ltd Servers, for the purpose of running this competition, and to keep track of all requests.").font(.system(size: 10))
                        }
                        if (Fname != "" && !Femail.isEmpty && !Fgender.isEmpty){
                        Button(action: {
                         //   CompForm.RequestForm(Rsong: \(song),Rartist: \(artist))
                            SubmitForm()
                        }) {
                            HStack {
                                    Spacer()
                                    Text("Submit")
                                    .font(.headline)
                                    .bold()
                                    Spacer()
                                }
                            .alert(isPresented: $showingAlert){
                                Alert(title: Text("Important message"), message: Text("You need to fill in Artist and Song to enter this competition"), dismissButton: .default(Text("Got it!")))
                            }
                            
                                
                        }.buttonStyle(SaveGradientButtonStyle())
                        }
                    }
            }
             else{
                    VStack{
                        
                        Image("F7Request&WIN!").resizable().aspectRatio(contentMode: .fit)
                        Spacer()
                        Text("Your Entered To WIN!").font(.largeTitle)
                        Text("You have already submitted your request.\nPlease come in.").multilineTextAlignment(.center)
                        Spacer()
                        Text(timeString(time: TimeInterval((Date().timeIntervalSince(UserSettings().lockRequest)))))
                            .font(.largeTitle)
                            .frame(width: geo.size.width / 2, height: 30, alignment: .center)
                            .background(Capsule().fill(Color.black))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
            
        }
        .navigationBarTitle("Request & Win - Fresh7@7",displayMode: .inline)
      
       
            .onAppear{
                
                //Send data to dataA
                Flurry.logEvent("RequestSong_Fresh7@7")
              
                
                
            }
         }
        
    
}
