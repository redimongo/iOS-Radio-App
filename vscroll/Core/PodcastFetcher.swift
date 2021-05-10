//
//  PodcastFetcher.swift
//  vscroll
//
//  Created by Russell Harrower on 21/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI

// Add this top level struct to
// decode properly

// PODCASTS
struct PodPost: Codable {
    var programs: [PodEpisode]
}

struct PodEpisode: Codable {
    var episode : [PodProgram]
}

struct PodProgram: Codable , Identifiable  {
  var id,title,enclosureurl,summary,duration:String

  private enum CodingKeys : String, CodingKey {
    case id = "_id", title , enclosureurl , summary, duration
  }
}





class PodApi {
   // Func to print data
   func getPodcast(podurl:String,completion: @escaping ([PodProgram]) -> ()) {
     
    let podurl = podurl
    
        guard let url = URL(string: "https://api.drn1.com.au/api-access/programs/\(podurl)") else { return }
           
            URLSession.shared.dataTask(with: url) { ( data, _, _) in
                             if let data = data {
                                 do {
                                     let podcast = try JSONDecoder().decode(PodPost.self, from: data)
                                     if let track = podcast.programs.first?.episode {
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
