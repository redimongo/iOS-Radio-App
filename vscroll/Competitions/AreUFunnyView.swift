//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 10/05/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK
//import KingfisherSwiftUI



struct AreUFunnyView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State private var joke: String = ""
   // @State private var artist: String = ""
    
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
        if(joke.isEmpty){
            showingAlert = true
        }
        else{
            userSettings.lockFunny = Date()
            print(CompForm().areufunnyForm(RJoke: joke))
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
            if let diff = Calendar.current.dateComponents([.hour], from: UserSettings().lockFunny, to: Date()).hour, diff > 24 {
            
                    Form {
                        VStack(alignment: .leading){
                                 Image("AreUFunny").resizable().aspectRatio(contentMode: .fill)
                                
                        }
                        Section(header: Text("Your Profile")) {
                           
                                TextField("First Name", text: $userSettings.firstname)
                                    .disabled(true)
                                
                                TextField("Last Name", text: $userSettings.lastname)
                                    .disabled(true)
                            
                                
                                TextField("Email Address", text: $Femail)
                                    .disabled(true)
                            
                                TextField("Mobile", text: $userSettings.mobile)
                                    .disabled(true)
                                
                                TextField("Gender", text: $Fgender)
                                    .disabled(true)
                                
                                DatePicker(LocalizedStringKey("D.O.B"),selection: $Fdob,in: ...Date(),
                                           displayedComponents: .date).disabled(true)
                            
                            if (Fname.isEmpty || Femail.isEmpty || Fgender.isEmpty || Fage <= 18){
                                Text("To enter this competition you need to fillout your user profile.")
                                
                                NavigationLink(destination:SettingsView()) {
                                    Text("Your Profile")
                                        .frame(width: geo.size.width, height: 100, alignment: .center)
                                        .background(Color.green)
                                        .padding(-30)
                                               
                                }
                                }
                                
                        }
                        Section(header: Text("Your Joke")){
                            if #available(iOS 14.0, *) {
                                TextEditor(text: $joke) .padding()
                            } else {
                                // Fallback on earlier versions
                                TextField("Joke", text: $joke)
                            }
                            
                        }
                        
                        
                        Section(header: Text("Terms")){
                            Text("1) Entrants acknowledge that Apple is not a participant in or sponsor of this competition.\n2) Entrants understand that the winner will recieve an electronic e-ticket that will be sent to their registered profile email address.\n3) Radio Media Pty Ltd is not liable for the electronic e-ticket once it has been sent.\n4) Entrants agree not to hold Radio Media Pty Ltd liable for any cancelation or changes to prizes.\n5) Entrants understand that the prize can not be exchanged for cash.\n6) Prize will be a double pass to a comedy show hosted by NYEvents.\n7) Winner/s will be announced during the show and will have to answer their phone within 5 rings to claim prize.\n8) Entrants understand that their personal information will be stored on Radio Media Pty Ltd Servers and maybe passed onto NY Events, for the purpose of running this competition, and to keep track of all entries.\n9) Enterants agree to opt-out if they choose from NY Events newsletter.").font(.system(size: 10))
                        }
                        
                        if (Fname != "" && !Femail.isEmpty && !Fgender.isEmpty && Fage >= 18){
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
                                        Alert(title: Text("Important message"), message: Text("You need to fill in joke to enter this competition"), dismissButton: .default(Text("Got it!")))
                                    }
                                    
                            }.buttonStyle(SaveGradientButtonStyle())
                        }
                        
                    }
            }
             else{
                    VStack{
                        
                        Image("AreUFunny").resizable().aspectRatio(contentMode: .fit)
                        Spacer()
                        Text("Your Entered To WIN!").font(.largeTitle)
                        Text("You have already submitted your Joke.\nPlease come back in.").multilineTextAlignment(.center)
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
        .navigationBarTitle("So U Think Your Funny?",displayMode: .inline)
      
       
            .onAppear{
                Fname = UserSettings().firstname
                Flast = UserSettings().lastname
                Fgender = UserSettings().gender
                Fdob = UserSettings().dateofbirth
                Fage = UserSettings().age
                Femail = UserSettings().email
                //Send data to dataA
                Flurry.logEvent("SoUThinkYourFunny_DrivingUHome")
              
                
                
            }
         }
        
    
}
