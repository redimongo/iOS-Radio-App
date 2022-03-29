import SwiftUI
//import Combine
// Add this top level struct to
// decode properly

// PODCASTS
struct Post: Codable {
    var programs: [Program]
}

struct Program: Codable , Identifiable  {
  var id,title,url,icon,banner:String

  private enum CodingKeys : String, CodingKey {
    case id = "_id", title , url , icon , banner
  }
}

// STATION
struct Sdata: Codable {
    var data: [Station]
}

struct Station: Codable , Identifiable  {
  var id,name,imageurl,listenlive:String

  private enum CodingKeys : String, CodingKey {
    case id = "_id", name , imageurl , listenlive
  }
}




class Api {
    //var subscriptions: Set<AnyCancellable> = .init()

    
    func getShows(station:String,completion: @escaping ([Program]) -> ()) {
        guard let url = URL(string: "https://api.drn1.com.au/api-access/programs/\(station)") else { return }
          
          URLSession.shared.dataTask(with: url) { (data, response, error) in
         
            if error != nil{
            //    getShows(station:\(station), completion: ([Program]) -> ())
            
                DispatchQueue.main.async{
                    // The array is stored under programs now
                    
                    completion([DRN1.Program(id: "0", title: "ERROR", url: "ERROR", icon: "https://storage.googleapis.com/radiomediapodcast/PopYourCherri/PopYourCherriLogo.png", banner: "https://storage.googleapis.com/radiomediapodcast/PopYourCherri/Popyourcherribanner.png")])
                }
                return
            }
              // Based on the updated structs, you would no
              // longer be decoding an array
              
            
            let post = try! JSONDecoder().decode(Post.self, from: data!)
              DispatchQueue.main.async{
                  // The array is stored under programs now
               // print(post.programs)
                  completion(post.programs)
              }              
          }
      .resume()
      }

    
    
    
    

    func getStations(completion: @escaping ([Station]) -> ()) {
        guard let url = URL(string: "https://api.drn1.com.au/station/allstations") else { return }
       
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if error != nil{
            //    getShows(station:\(station), completion: ([Program]) -> ())
            
                DispatchQueue.main.async{
                    // The array is stored under programs now
                  
                    completion([DRN1.Station(id: "0", name: "ERROR", imageurl: "https://storage.googleapis.com/radiomediapodcast/PopYourCherri/PopYourCherriLogo.png",listenlive: "ERROR")])
                }
                return
            }
            // Based on the updated structs, you would no
            // longer be decoding an array
            let station = try! JSONDecoder().decode(Sdata.self, from: data!)
            DispatchQueue.main.async{
                // The array is stored under station now
                completion(station.data)
            }
            
        }
    .resume()
    }
    
    
 
}


