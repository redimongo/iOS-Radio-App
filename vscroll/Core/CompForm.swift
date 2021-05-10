//
//  CompForms.Swift
//  DRN1
//
//  Created by Russell Harrower on 3/5/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//
import Foundation
import SwiftUI


struct Soru: Codable {
    var programs: [sProgram]
}

struct sProgram: Codable , Identifiable  {
  var id,title:String

  private enum CodingKeys : String, CodingKey {
    case id = "_id", title
  }
}

class CompForm {
    
    func requestForm(Rsong: String, Rartist: String){
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        var DOBSend: String{
            return "\(UserSettings().dateofbirth)"
        }
        let parameters = ["Enquiry":"Request Song","Program":"Fresh7@7","FirstName":UserSettings().firstname,"LastName":UserSettings().lastname,"DOB": DOBSend,"Song": Rsong, "Artist": Rartist]

            //create the url with URL
            let url = URL(string: "https://api.drn1.com.au/forms/fresh7at7Request")! //change the url

            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                print(try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted))
            
            } catch let error {
                print(error.localizedDescription)
            }

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                    }
                } catch let error {
                    print("this ran error")
                    print(error.localizedDescription)
                }
            })
            task.resume()
        
        
        
      /*  let locationurl = URL(string: "https://api.drn1.com.au:9000/listener?uuid=\(MusicPlayer.uuid ?? "")&song=\(Rsong)&artist=\(Rartist)&username=\(UserSettings().username)")!
        //print(locationurl )
        // print("location: \(MusicPlayer.uuid ?? "") lat: \(latitude), long: \(longitude)")
         
          URLSession.shared.dataTask(with: locationurl) { (data, res, err) in
          DispatchQueue.main.async{
           // print("The Server should of updated")
            
              //  guard let data = data else { return }
                
            }
             return
        }.resume()*/
    }
}

