//
//  Podcasts.swift
//  vscroll
//
//  Created by Russell Harrower on 18/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK
import Kingfisher

struct ListHeader: View {
    let post: Program
    var body: some View {
        KFImage(URL(string: self.post.banner))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
        
    }
}



struct Podcasts: View {
    
     let post: Program

    
    @State var showingDetail = false
    @State var podcast: [PodProgram] = []
    
    var body: some View {
        Section(header: ListHeader(post: self.post)) {
            List {
                        ForEach(podcast) { podcast in
                            HStack{
                                VStack{
                                    Text(podcast.title).font(.title).frame(maxWidth: .infinity, alignment: .leading)
                                    Text(podcast.summary).frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                Image(systemName: "play.circle").resizable().frame(width: 40, height:40)
                                
                            } .onTapGesture {
                                
                                                print(podcast.duration.inSeconds)
                                                let data = ["podcast": post.title, "Episode_title":podcast.title]
                                                Flurry.logEvent("Podcast_Play", withParameters: data)
                                
                                               self.showingDetail.toggle()
                                                            MusicPlayer.shared.startBackgroundMusic(url:"https://chrt.fm/track/55D7EE/dts.podtrac.com/redirect.mp3/\(podcast.enclosureurl)", type: "podcast")
                                MusicPlayer.shared.getArtBoard(artist: self.post.title, song: podcast.title, cover:self.post.icon, urls:"", duration: podcast.duration.inSeconds)
                                              }
                                            .sheet(isPresented: self.$showingDetail) {
                                                MediaPlayerView()
                                                          
                                            }
                        }
                    }
            }.listStyle(GroupedListStyle())
            .onAppear{
                //Send data to dataA
                Flurry.logEvent("Podcast_View", withParameters: ["podcast": post.title])
            //RUN CODE TO Fetch podcast episodes.
                
                print("podcast")
                PodApi().getPodcast(podurl: self.post.url){ (podcast) in
                    self.podcast = podcast
                }
            }
            .navigationBarTitle(Text(post.title), displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
           
      
        
        
    
    }
        
}

extension String {
    /**
     Converts a string of format HH:mm:ss into seconds
     ### Expected string format ###
     ````
        HH:mm:ss or mm:ss
     ````
     ### Usage ###
     ````
        let string = "1:10:02"
        let seconds = string.inSeconds  // Output: 4202
     ````
     - Returns: Seconds in Int or if conversion is impossible, 0
     */
    var inSeconds : Int {
        var total = 0
        let secondRatio = [1, 60, 3600]    // ss:mm:HH
        for (i, item) in self.components(separatedBy: ":").reversed().enumerated() {
            if i >= secondRatio.count { break }
            total = total + (Int(item) ?? 0) * secondRatio[i]
        }
        return total
    }
}
