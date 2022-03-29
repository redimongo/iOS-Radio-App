import Foundation
import CarPlay
import Kingfisher
import SwiftUI

class Nowplayinginfo{
    
    func getsong(){
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if(MusicPlayer.mediatype == "radio"){
            AdStichrApi().getSong(station: AdStichrApi.station){ (AdStichrNP) in
            //     self.cover = AdStichrNP.imageurl ?? ""
           // print(AdStichrNP.imageurl ?? "None Found")
       
            print(AdStichrApi.station)
            print(AdStichrNP.artist)
            print(AdStichrNP.imageurl!)
            MusicPlayer.shared.getArtBoard(artist: AdStichrNP.artist, song: AdStichrNP.title, cover: AdStichrNP.imageurl!, urls: AdStichrNP.url ?? "", duration: 0)
            }
            //Flurry.logEvent("Track_Change", withParameters: ["artist": self.artist, "song":self.song])
        }
      
        
    }
       // print(AdStichrNP)
    }
}



class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfactController: CPInterfaceController?
    private var selection = 1
    @State var stations: [Station] = []
    
    // Load the list template
   
    
    func checkmediaplayer(){
        if(MusicPlayer.shared.player!.rate != 0)
        {
            self.selection = 1
        }
        else
        {
            self.selection = 0
        }
        
    }
    
    
    
     func loadList(withStations stations: [CPListItem]) {
        
        let section = CPListSection(items: stations)
        let listTemplate = CPListTemplate(title: "Select a station",
                                          sections: [section])
        
        // Set the root template of the CarPlay interface
        // to the list template with a completion handler
        interfaceController?.setRootTemplate(listTemplate,
                                             animated: true) { success, error in
            
            // add anything you want after setting the root template
        }
      
        
    }
    
    
  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
   
      Api().getStations { (stations) in
          
          var stationItems: [CPListItem] = []
          
          self.stations = stations
          
          for station in stations {
              
              let item = CPListItem(text: station.name,
                                    detailText: station.name
                                   // image: imageLiteralResourceName:"DRN1Logo")
              )
              
              item.handler = { [weak self] item, completion in
                  
                  // manage what should happen on tap
                  // like navigate to NowPlayingView
                  print(item)
              }
              
              stationItems.append(item)
          }
          
          
        
          
            self.loadList(withStations: stationItems)
      }

      
      interfactController?.setRootTemplate(listTemplate, animated: false)
      
    
     // interfaceController.setRootTemplate(listTemplate, animated: false, completion: nil)
   /* let DRN1 = CPListItem(text: "DRN1", detailText: "Perth's No.1 Online Station.")
    let Hits = CPListItem(text: "DRN1 Hits", detailText: "Top 40 songs and yesturdays hits.")
    let United = CPListItem(text: "DRN1 United", detailText: "Perth's Dedicated LGBTIQA+ Station.")
    let Dance = CPListItem(text: "DRN1 Dance", detailText: "Playing the hottest dance tracks.")
    
   
    
    if #available(iOS 14.0, *) {
        let nowplay = CPNowPlayingTemplate.shared
        
        DRN1.setImage(UIImage(imageLiteralResourceName:"DRN1Logo"))
        DRN1.handler = { item, completion in
            print("selected DRN1")
            AdStichrApi.station = "DRN1"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1", type: "radio")
            Nowplayinginfo().getsong()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                interfaceController.pushTemplate(nowplay, animated: true,completion:nil)
                completion()
            }
        }
        
        Hits.setImage(UIImage(imageLiteralResourceName:"DRN1Hits"))
        Hits.handler = { item, completion in
            print("selected Hits")
            MusicPlayer.shared.player?.pause()
            AdStichrApi.station = "DRN1Hits"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1Hits", type: "radio")
            Nowplayinginfo().getsong()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
               
                //interfaceController.presentTemplate(nowplay, animated: false)
                interfaceController.pushTemplate(nowplay, animated: true,completion:nil)
                completion()
                
            }
        }
        
        United.setImage(UIImage(imageLiteralResourceName:"DRN1United"))
        United.handler = { item, completion in
            print("selected United")
            AdStichrApi.station = "DRN1United"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1United", type: "radio")
              // do work in the UI thread here
            Nowplayinginfo().getsong()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                interfaceController.pushTemplate(nowplay, animated: true,completion:nil)
                completion()
            }
            
            
            
        }
        
        Dance.setImage(UIImage(imageLiteralResourceName:"DRN1Dance"))
        Dance.handler = { item, completion in
            print("selected Dance")
            AdStichrApi.station = "dance"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/dance", type: "radio")
            Nowplayinginfo().getsong()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true,completion:nil)
            }
        }
        
        
        
        
    } else {
        // Fallback on earlier versions
    }
    
    
    
    let listTemplate = CPListTemplate(title: "Select a Station", sections: [CPListSection(items:[DRN1,United,Hits,Dance])])
   // print("HUGE TEST TO SEE IF THIS IS RUNNING")
    //let rootTemplate = self.makeRootTemplate()
    
    interfaceController.setRootTemplate(listTemplate, animated: false, completion: nil)
    
    //interfactController?.setRootTemplate(listTemplate, animated: false)
    //self.interfaceController = interfaceController
        */
  }
}

