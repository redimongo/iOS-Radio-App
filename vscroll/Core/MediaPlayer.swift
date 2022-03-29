import SwiftUI
//import Foundation
import AVFoundation
import MediaPlayer
import AVKit

struct NowPlayingData: Codable , Identifiable  {
  var id,artist,song,cover:String

  private enum CodingKeys : String, CodingKey {
    case id = "_id", artist , song , cover
  }
}

class MusicPlayer {
static let shared = MusicPlayer()
static var mediatype = ""
static var artist = ""
static var song = ""
static var cover = ""
static var urls = ""
static var dur = 0
static var uuid = UIDevice.current.identifierForVendor?.uuidString
static var playbackSlider:UISlider?


var player: AVPlayer?
let playerViewController = AVPlayerViewController()

    
    
    
    func gettype(completion: @escaping (String) -> Void){
          
            completion(MusicPlayer.mediatype)
       
      }
      
      func getPodCastPlayerNP(completion: @escaping (NowPlayingData) -> ()) {
       // Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { (timer) in
          let songdata = "{\"_id\": \"1\",\"song\": \"\(MusicPlayer.song)\",\"artist\": \"\(MusicPlayer.artist)\", \"cover\": \"\(MusicPlayer.cover)\"}"
          let data: Foundation.Data = songdata.data(using: .utf8)!
          
          let podcast = try! JSONDecoder().decode(NowPlayingData.self, from: data)
                
                         //print(data!)
                        // let episode = podcast.programs
                        DispatchQueue.main.async{
                            // The array is stored under programs now
                          //print(podcast)
                          completion(podcast)
                        }
         // }
      }

    func startBackgroundMusic(url: String, type:String) {
     
        MusicPlayer.mediatype = String(type)
        
        //let urlString = "http://stream.radiomedia.com.au:8003/stream"
        let urlString = url+"?uuid="+MusicPlayer.uuid!
        print(urlString)
        guard let url = URL.init(string: urlString) else { return }

        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
      
        do {

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker, .mixWithOthers, .allowAirPlay])
            print("Playback OK")
           // let defaults = UserDefaults.standard
           // defaults.set("1", forKey: defaultsKeys.musicplayer_connected)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
           // let defaults = UserDefaults.standard
          //  defaults.set("0", forKey: defaultsKeys.musicplayer_connected)
            print(error)
        }

         #if targetEnvironment(simulator)

        self.playerViewController.player = player
        self.playerViewController.player?.play()
        print("SIMULATOR")

         #else

        self.setupRemoteTransportControls()
        player?.play()

        #endif
        

    }
    
    
    func startBackgroundMusicTwo() {

        
        let urlString = "http://stream.radiomedia.com.au:8003/stream"
        //let urlString = url
        guard let url = URL.init(string: urlString) else { return }

        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
      
        do {

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker, .mixWithOthers, .allowAirPlay])
            print("Playback OK")
           // let defaults = UserDefaults.standard
           // defaults.set("1", forKey: defaultsKeys.musicplayer_connected)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
           // let defaults = UserDefaults.standard
          //  defaults.set("0", forKey: defaultsKeys.musicplayer_connected)
            print(error)
        }

         #if targetEnvironment(simulator)

        self.playerViewController.player = player
        self.playerViewController.player?.play()
        print("SIMULATOR")

         #else

        self.setupRemoteTransportControls()
        player?.play()

        #endif

    }




func setupRemoteTransportControls() {
   // Get the shared MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()

    let changePlaybackPositionCommand = commandCenter.changePlaybackPositionCommand
    changePlaybackPositionCommand.isEnabled = true
    changePlaybackPositionCommand.addTarget { event in
            let seconds = (event as? MPChangePlaybackPositionCommandEvent)?.positionTime ?? 0
            let time = CMTime(seconds: seconds, preferredTimescale: 1)
            self.player?.seek(to: time)
            return .success
        }
    
    let skipBackwardCommand = commandCenter.skipBackwardCommand
    if(MusicPlayer.mediatype == "podcast")
    {
    skipBackwardCommand.isEnabled = true
    skipBackwardCommand.preferredIntervals = [NSNumber(value: 10)]
    skipBackwardCommand.addTarget(handler: skipBackward)
      
    }
    else{
        skipBackwardCommand.isEnabled = false
    }
    
    
   
    let skipForwardCommand = commandCenter.skipForwardCommand
    if(MusicPlayer.mediatype == "podcast")
    {
    skipForwardCommand.isEnabled = true
    skipForwardCommand.preferredIntervals = [NSNumber(value: 30)]
    }
    else{
        skipForwardCommand.isEnabled = false
    }
    skipForwardCommand.addTarget(handler: skipForward)
   
    
    
    // Add handler for Play Command
    commandCenter.playCommand.addTarget { [unowned self] event in
        if self.player?.rate == 0.0 {
            self.player?.play()
            return .success
        }
        return .commandFailed
    }

    // Add handler for Pause Command
    commandCenter.pauseCommand.addTarget { [unowned self] event in
        if self.player?.rate == 1.0 {
            self.player?.pause()
            MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(Double((self.player?.currentTime().seconds)!))
            return .success
        }
        return .commandFailed
    }

    
    
    
    func skipBackward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
                
                //self.player?.seek(to: CMTimeMakeWithSeconds(CMTimeGetSeconds((self.player?.currentTime())!).advanced(by: -30), preferredTimescale: 1))
                // print(CMTimeGetSeconds((self.player?.currentTime())!)) //Output: 42
                
                //print(event.interval)
                //self.player!.seek(to: CMTimeMakeWithSeconds(CMTimeGetSeconds((self.player?.currentTime())!).advanced(by: -30), preferredTimescale: 1))
                let currentTime = self.player?.currentTime()
                self.player?.seek(to: CMTime(seconds: currentTime!.seconds - 10, preferredTimescale: 1), completionHandler: { isCompleted in
                    if isCompleted {
                        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(Double((self.player?.currentTime().seconds)!))
                    }
                })
                return .success
                
            }
            
            func skipForward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
                //self.player?.seek(to: CMTimeMakeWithSeconds(CMTimeGetSeconds((self.player?.currentTime())!).advanced(by: 30), preferredTimescale: 1))
                let currentTime = self.player?.currentTime()
                self.player?.seek(to: CMTime(seconds: currentTime!.seconds + 30, preferredTimescale: 1), completionHandler: { isCompleted in
                    if isCompleted {
                        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(Double((self.player?.currentTime().seconds)!))
                    }
                })
            
                
                
                
                return .success
            }
    

}
    
    func rw(){
        let currentTime = self.player?.currentTime()
        self.player?.seek(to: CMTime(seconds: currentTime!.seconds - 10, preferredTimescale: 1), completionHandler: { isCompleted in
            if isCompleted {
                MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(Double((self.player?.currentTime().seconds)!))
            }
        })
    }
    func ff(){
        let currentTime = self.player?.currentTime()
        self.player?.seek(to: CMTime(seconds: currentTime!.seconds + 30, preferredTimescale: 1), completionHandler: { isCompleted in
            if isCompleted {
                MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(Double((self.player?.currentTime().seconds)!))
            }
        })
    }
    
    
    func nowplaying(with artwork: MPMediaItemArtwork, artist: String, song: String, duration: Int){
  
        
        if(duration == 0){
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                  MPMediaItemPropertyTitle:song,
                  MPMediaItemPropertyArtist:artist,
                  MPMediaItemPropertyArtwork: artwork,
                  MPNowPlayingInfoPropertyIsLiveStream: true
            ]
        }
        else{

            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                  MPMediaItemPropertyTitle:song,
                  MPMediaItemPropertyArtist:artist,
                  MPMediaItemPropertyArtwork: artwork,
                  MPNowPlayingInfoPropertyIsLiveStream: false,
                  MPMediaItemPropertyPlaybackDuration: duration,
                  MPNowPlayingInfoPropertyPlaybackRate: 1.0,
                  MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds((self.player?.currentTime())!)
                  
            ]
        }

   // self.getArtBoard();
}


func setupNowPlayingInfo(with artwork: MPMediaItemArtwork) {
      MPNowPlayingInfoCenter.default().nowPlayingInfo = [
           MPMediaItemPropertyTitle: "Some name",
           MPMediaItemPropertyArtist: "Some name",
           MPMediaItemPropertyArtwork: artwork,
           //MPMediaItemPropertyPlaybackDuration: CMTimeGetSeconds(currentItem.duration),
           //MPNowPlayingInfoPropertyPlaybackRate: 1,
           //MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(currentItem.currentTime())
       ]
   }



func getData(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
        if let data = data {
            completion(UIImage(data:data))
        }
    })
        .resume()
}

    func getArtBoard(artist: String, song: String, cover: String, urls: String, duration: Int) {
   // MusicPlayer.JN = "[{'artist': \(artist), 'song':\(song), 'cover': \(cover)}]"
    MusicPlayer.artist = artist
    MusicPlayer.song = song
    MusicPlayer.cover = cover
    MusicPlayer.urls = urls
    
    
    guard let url = URL(string: cover) else { return }
    getData(from: url) { [weak self] image in
        guard let self = self,
            let downloadedImage = image else {
                return
        }
        let artwork = MPMediaItemArtwork.init(boundsSize: downloadedImage.size, requestHandler: { _ -> UIImage in
            return downloadedImage
        })
        self.nowplaying(with: artwork, artist: artist, song: song, duration: duration)
    }
}



    func stopBackgroundMusic() {
        guard let player = player else { return }
        player.pause()

}
}
