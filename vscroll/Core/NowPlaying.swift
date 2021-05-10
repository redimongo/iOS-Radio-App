//
//  NowPlaying.swift
//  vscroll
//
//  Created by Russell Harrower on 25/8/20.
//  Copyright © 2020 Radio Media PTY LTD. All rights reserved.
//
import UIKit
import SwiftUI

// Add this top level struct to
// decode properly

// NowPlaying Radio Station Script

struct Nowplayng: Decodable{
    let data: [Data]
}

struct Data: Decodable{
    let track: Trackinfo
}
struct Trackinfo: Decodable {
    let title: String
    let artist: String
    let imageurl: String?
    let type: String?
    let url: String?
}



class AdStichrApi {
static var station = "DRN1"
    
    
    
    //Func to update Now playing info
   
   // Func to print data
   func getSong(station:String,completion: @escaping (Trackinfo) -> ()) {
  
    let stationurl = station
   
    
    
    guard let urls = URL(string: "https://api.drn1.com.au:9000/nowplaying/\(stationurl)?uuid=\(MusicPlayer.uuid!)") else { return }
              
   
             URLSession.shared.dataTask(with: urls) { ( data, _, _) in
                  if let data = data {
                      do {
                          let podcast = try JSONDecoder().decode(Nowplayng.self, from: data)
                          if let track = podcast.data.first?.track {
                              DispatchQueue.main.async {
                                  completion(track)
                              }
                          }
                          // But what do you want to do if there isn't a track here? (see below)
                      } catch {
                          // here, you need to deal with the error. At a minimum you need to
                          // log it. But you likely need to modify your completion handler to
                          // accept a Result or other way of passing errors back.
                      }
                  }
                  // And here, too. What if there's a web server error response? (see above)
              }
       .resume()
    
   }
    
    
    func PlayAudio(){
          DispatchQueue.main.async{
            MusicPlayer().startBackgroundMusic(url: "http://stream.radiomedia.com.au:8003/stream",type: "radio")
          }
    }
    
}
