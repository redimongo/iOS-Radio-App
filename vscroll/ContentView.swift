//
//  ContentView.swift
//  vscroll
//
//  Created by Russell Harrower on 17/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//
import SwiftUI
import AVKit
import Flurry_iOS_SDK
import Kingfisher
import KingfisherSwiftUI
import CoreLocation


struct ContentView: SwiftUI.View {
    //@EnvironmentObject var monitor: Monitor
    @State var isNavigationBarHidden: Bool = true
    @ObservedObject var location = LocationManager()

   
    let queue = DispatchQueue(label: "Monitor")
    
    var lat: String{
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }
    
    var lon: String{
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    
        self.location.startUpdating()
    }
    
    
    
    
    @State var uuid = String(MusicPlayer.uuid!)
    @State var speed:Int = 0
    @State var connected: Int = 0
    @State var errorDetail = false
    @State var showingDetail = false
    @State var stations: [Station] = []
    @State var posts: [Program] = []
    @State var lifeshows: [Program] = []
    @State var unitedshows: [Program] = []

    
    /* functions for each stations shows */
    func getShows(){
        Api().getStations { (stations) in
                       self.stations = stations
        }
        
        Api().getShows(station:"DRN1United"){ (posts) in
            if((posts.first!.title as String) == "ERROR"){
                print("THEIR WAS AN ERROR Getting United Shows")
                getShows()
            }
          self.unitedshows = posts
        }
        
        Api().getShows(station:"1Life"){ (posts) in
            if((posts.first!.title as String) == "ERROR"){
                print("THEIR WAS AN ERROR Getting 1Life Shows")
                getShows()
            }
            self.lifeshows = posts
        }
        
        Api().getShows(station:"DRN1"){ (posts) in
            if((posts.first!.title as String) == "ERROR"){
                print("THEIR WAS AN ERROR Getting DRN1 Shows")
                getShows()
            }
            self.posts = posts
        }
    }
    //END STATION AND SHOW SECTION
    
    
    var body: some SwiftUI.View {
        NavigationView {
          GeometryReader { geo in
            Group {
               /* if(self.lat == "0.0" && self.lon == "0.0"){
                
                    LocationDisabled()
                        
                        
        
                }
                else*/ if self.stations.isEmpty {
                Text("Loading")
                //this must be empty
                //.navigationBarHidden(true)
                      
                }else {
            ScrollView {
                VStack(alignment: .leading){
                    MediaPlayerView()
                    .frame(width:geo.size.width, height:270)
                    
               // }.frame(width:geo.size.width, height:250)
                    .onTapGesture {
                     self.showingDetail.toggle()
                    }
                        .sheet(isPresented: self.$showingDetail) {
                            MediaPlayerView()
                                
                        }
               // Divider()
                VStack(alignment: .leading){
                    Spacer(minLength: 2)
                        //STATIONS
                        Text("Our Stations")
                        .lineSpacing(30)
                        .padding(5)
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .bottom, spacing: 10) {
                                                ForEach(self.stations) { station in
                                                    //return
                                                   Button(action: {
                                                    /*Analytics.logEvent("Station_Change",parameters: [
                                                        "name": station.name
                                                    ])*/
                                                    if(station.name == "ERROR"){
                                                        print(station.name)
                                                        self.errorDetail.toggle()
                                                    }else{
                                                    Flurry.logEvent("Station_Change", withParameters: ["name": station.name])
                                                    AdStichrApi.station = station.name
                                                    MusicPlayer.shared.startBackgroundMusic(url:station.listenlive, type: "radio")
                                                        self.showingDetail.toggle()
                                                    }
                                                   
                                                   }) {
                                                    
                                                    if #available(iOS 14.0, *) {
                                                        if(station.name == "ERROR"){
                                                        Image(uiImage: UIImage(named: "NetworkOutageCD")!)
                                                            .resizable()
                                                            .renderingMode(.original)
                                                            .frame(width:geo.size.width, height:geo.size.width / 2.5)
                                                            
                                                            .sheet(isPresented: self.$showingDetail) {
                                                                MediaPlayerView()
                                                            }
                                                            .fullScreenCover(isPresented: self.$errorDetail, content: NetworkOutageView.init)
                                                            
                                                        }
                                                        else{
                                                        KFImage(URL(string: station.imageurl)!)
                                                            .resizable()
                                                            .renderingMode(.original)
                                                            .frame(width:geo.size.width / 2.5, height:geo.size.width / 2.5)
                                                            
                                                            .sheet(isPresented: self.$showingDetail) {
                                                                MediaPlayerView()
                                                            }
                                                            .fullScreenCover(isPresented: self.$errorDetail, content: NetworkOutageView.init)
                                                        }
                                                            
                                                    } else {
                                                        if(station.name == "ERROR"){
                                                        Image(uiImage: UIImage(named: "NetworkOutageCD")!)
                                                            .resizable()
                                                            .renderingMode(.original)
                                                            .frame(width:geo.size.width, height:geo.size.width / 2.5)
                                                            
                                                            .sheet(isPresented: self.$showingDetail) {
                                                                MediaPlayerView()
                                                            }
                                                            .sheet(isPresented: self.$errorDetail, content: NetworkOutageView.init)
                                                        }
                                                        else{
                                                        KFImage(URL(string: station.imageurl)!)
                                                            .resizable()
                                                            .renderingMode(.original)
                                                            .frame(width:geo.size.width / 2.5, height:geo.size.width / 2.5)
                                                            
                                                            .sheet(isPresented: self.$showingDetail) {
                                                                MediaPlayerView()
                                                            }
                                                            .sheet(isPresented: self.$errorDetail) {
                                                                NetworkOutageView()
                                                            }
                                                        }
                                                    }
                                                         
                                                    
                                                }
                                            }
                                                
                                            }.frame(height: geo.size.width / 2.5)
                        }.frame(height: geo.size.width / 2.5)
                }
                    VStack(alignment: .leading){
                    Divider()
                    //PODCAST
                    Text("DRN1 Shows")
                    .lineSpacing(20)
                    .padding(5)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 10) {
                            ForEach(self.posts) { post in
                                //return
                                if(post.title == "ERROR"){
                                    Image(uiImage: UIImage(named: "NetworkOutage")!)
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width:geo.size.width, height:geo.size.width / 2.5)
                                        
                                }
                                else{
                                
                                    NavigationLink(destination: Podcasts(post: post)){
                                        KFImage(URL(string: post.icon))
                                            .resizable()
                                            .renderingMode(.original)
                                            .frame(width:geo.size.width / 3, height:geo.size.width / 3)
                                        
                                    }
                                    
                                }
                            }
                            
                            

                        }.frame(height: geo.size.width / 3)
                    }.frame(height: geo.size.width / 3)
                   
                }
                    VStack(alignment: .leading){
                    //United SHOWS
                    Divider()
                                    //PODCAST
                                    
                                    Text("UNITED Shows")
                                    .lineSpacing(20)
                                    .padding(5)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(self.unitedshows) { post in
                                                //return
                                                if(post.title == "ERROR"){
                                                    Image(uiImage: UIImage(named: "NetworkOutageCD")!)
                                                        .resizable()
                                                        .renderingMode(.original)
                                                        .frame(width:geo.size.width, height:geo.size.width / 2.5)
                                                        
                                                }
                                                else{
                                                
                                                    NavigationLink(destination: Podcasts(post: post)){
                                                   
                                                     KFImage(URL(string: post.icon),  options: [.processor(ResizingImageProcessor(referenceSize: .init(width: geo.size.width / 4,height:geo.size.width / 3)))])
                                                        .resizable()
                                                        .renderingMode(.original)
                                                        .frame(width:geo.size.width / 3, height:geo.size.width / 3)
                                                    }
                                                    }
                                                }
                                            
                                            

                                        }.frame(height: geo.size.width / 3)
                                    }.frame(height: geo.size.width / 3)
                    }
                    VStack(alignment: .leading){
                    //1LIFE SHOWS
                    Divider()
                                    //PODCAST
                                    
                                    Text("1Life Shows")
                                    .lineSpacing(20)
                                    .padding(5)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            ForEach(self.lifeshows) { post in
                                                //return
                                                NavigationLink(destination: Podcasts(post: post)){
                                               
                                                 KFImage(URL(string: post.icon),  options: [.processor(ResizingImageProcessor(referenceSize: .init(width: geo.size.width / 4,height:geo.size.width / 3)))])
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .frame(width:geo.size.width / 3, height:geo.size.width / 3)
                                                }
                                            }
                                            
                                            

                                        }.frame(height: geo.size.width / 3)
                                    }.frame(height: geo.size.width / 3)
                    
                }
                
                }
            
            }
            }
                
            }
                           //.navigationBarTitle("")
                           //.navigationBarBackButtonHidden(true)
                           .navigationBarHidden(true)
            }
        
           
                        
         }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
         //   self.navigationViewStyle(StackNavigationViewStyle())
            
            
            getShows()
            
            
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.speed = LocationManager.Speed
            }
    
        }
        
        
    }
}



struct ContentView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}


