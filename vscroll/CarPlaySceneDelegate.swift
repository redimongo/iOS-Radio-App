import Foundation
import CarPlay



class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfactController: CPInterfaceController?
    private var selection = 1
  
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
    
    
    
  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
   
    
    let DRN1 = CPListItem(text: "DRN1", detailText: "Perth's No.1 Online Station.")
    let Hits = CPListItem(text: "DRN1 Hits", detailText: "Top 40 songs and yesturdays hits.")
    let United = CPListItem(text: "DRN1 United", detailText: "Perth's Dedicated LGBTIQA+ Station.")
    let Dance = CPListItem(text: "DRN1 Dance", detailText: "Playing the hottest dance tracks.")
    let Urban = CPListItem(text: "DRN1 Urban", detailText: "R&B / Hip-hop and the sound of Urban.")
   
    
    
    if #available(iOS 14.0, *) {
        let nowplay = CPNowPlayingTemplate.shared
        
        DRN1.setImage(UIImage(imageLiteralResourceName:"DRN1Logo"))
        DRN1.handler = { item, completion in
            print("selected DRN1")
            AdStichrApi.station = "DRN1"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1", type: "radio")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true)
            }
        }
        
        Hits.setImage(UIImage(imageLiteralResourceName:"DRN1Hits"))
        Hits.handler = { item, completion in
            print("selected Hits")
            MusicPlayer.shared.player?.pause()
            AdStichrApi.station = "DRN1Hits"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true)
                MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1Hits", type: "radio")
                MusicPlayer.shared.player?.play()
                
            }
        }
        
        United.setImage(UIImage(imageLiteralResourceName:"DRN1United"))
        United.handler = { item, completion in
            print("selected United")
            AdStichrApi.station = "DRN1United"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1United", type: "radio")
              // do work in the UI thread here
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true)
            }
            
            
            
        }
        
        Dance.setImage(UIImage(imageLiteralResourceName:"DRN1Dance"))
        Dance.handler = { item, completion in
            print("selected Dance")
            AdStichrApi.station = "dance"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/dance", type: "radio")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true)
            }
        }
        
        Urban.setImage(UIImage(imageLiteralResourceName:"DRN1Urban"))
        Urban.handler = { item, completion in
            print("selected DRN1Urban")
            AdStichrApi.station = "DRN1Urban"
            MusicPlayer.shared.startBackgroundMusic(url:"https://api.drn1.com.au:9000/station/DRN1Urban", type: "radio")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                completion()
                interfaceController.pushTemplate(nowplay, animated: true)
            }
        }
        
        
    } else {
        // Fallback on earlier versions
    }
    
    
    
    let listTemplate = CPListTemplate(title: "Select a Station", sections: [CPListSection(items:[DRN1,United,Hits,Dance,Urban])])
    print("HUGE TEST TO SEE IF THIS IS RUNNING")
    //let rootTemplate = self.makeRootTemplate()
    
    interfaceController.setRootTemplate(listTemplate, animated: false)
    
    //interfactController?.setRootTemplate(listTemplate, animated: false)
    //self.interfaceController = interfaceController
        
  }
}

