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



struct BattleoftheBandsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State private var song: String = ""
    @State private var artist: String = ""
    
    //let string = UserSettings().state
    
    var Fname: String{
        return "\(userSettings.firstname)"
    }
    

    func SubmitForm(){
        //print(song)
        userSettings.lockRequest = Date()
        print(CompForm().requestForm(Rsong: song,Rartist: artist))
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
           
                        
            List{
                VStack(alignment: .leading){
                         Image("BattleOfTheBands").resizable().aspectRatio(contentMode: .fit)
                        
                }
                Section(header: Text("The Competition")) {
                           Text("For the first time WA bands will battle for the right to be named DRN1 Battle Of The Bands Winner.\n\nThe last year we have seen the arts and entertainment industry suffer at the hands of a global pandemic.\n\nHowever we have also seen bands and artists turn to online media and social networking platforms to promote their songs, do virtual concerts and release single tracks like never before.\n\nSo the team at DRN1 and our proud sponsors of Battle Of The Bands are giving you the opportunity to get your fans to vote for your track and make you the official \"DRN1 BATTLE OF THE BANDS\" 2021 winner.\n\nIt will be 100% fan based voting and best of all other bands fans get to listen to your song and maybe switch their vote.\n\nThe contest will be 100% online, and voting will go for 2 weeks. Full details will be released closer to the date.\n\nSo if this has you keen please register your interest via email botb@DRN1.com.au")
                        }
                Section(header: Text("Sponsors")) {
                           Text("If your a business that wants to support local artist and supply prizes and in return get your business promoted to local bands around WA then please email botb@drn1.com.au\n\nWe would love to work with you to create a great prize for the winning band.")
                        }
                Section(header: Text("The Rules")) {
                            Text("Bands will be able to enter 1 song, which is no longer than 4 minutes.\n\nListeners to DRN1 will vote via our iOS app.\n\nThe Winning band will win prizes. Prizes will be announced soon.\n\nSo is your band ready?\n\nNo Member is allow to play or be part of another entrant.\n\nBands must write orginal track.\n\nThe song must be no longer than 4 minutes.\n\nMust be a clean version available to be played on radio.\n\nEnterants must be willing to do PR, and interviews on DRN1.\n\nEnterants will need to promote their song for public fan voting.")
                }
                Section(header: Text("Judging")){
                    
                            Text("For the first time in Battle of the Bands. 100% of votes will be from the public.")
                        
                }
                Section(header: Text("Terms")){
                            Text("1) Entrants acknowledge that Apple is not a participant in or sponsor of this competition.\n\n2) prizes are not transferable to cash.\n\n3) Radio Media Pty Ltd is not liable for organising the winners collection of said prize.\n\n4) Winner/s will be announced at end of competition voting peroid to be announced.\n\n5) Entrants must be a Western Australia band / artist.\n\n6) Entrants must write orginal songs.\n\n7) Entrant must supply DRN1 with mp3 or wav version of the song for airplay and for on-demand listening for voting purpose.\n\n7) Entrants agree to promote their entry into the DRN1 Battle of the Bands competition.\n\n8) Entrants understand that their personal information will be stored on Radio Media Pty Ltd Servers, for the purpose of running this competition, and to keep track of all requests.\n\n9) Entrants found cheating will be disqualified.\n\n10) Entrants found taking samples of music from already released music will be disqualified.\n\n11) Entrants agree that 100% of the entrants song/track is orginal and owned by them.")//.font(.system(size: 10))
                    }
                Section(header: Text("Looking for more information?")){
                    Text("Please email: botb@drn1.com.au")
                }
            }
        }
            .onAppear{
                
                //Send data to dataA
                Flurry.logEvent("BattleoftheBands_2021")
              
                
                
            }
         }
        
    
}
