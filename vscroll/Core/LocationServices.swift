//
//  LocationManager.swift
//  CoreLocationDemo
//
//  Created by Sheikh Bayazid on 7/18/20.
//  Copyright © 2020 Sheikh Bayazid. All rights reserved.
//
import Foundation
import CoreLocation
import Combine
import UIKit
import SwiftUI


class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    static var LMlat = 0.0
    static var LMlong = 0.0
    static var Speed:Int = 0
    static var permission: String = "nil"
    @Published var lastKnownLocation: CLLocation?

    
//    var getLat: String {
//        return "\(lastKnownLocation?.coordinate.latitude)"
//    }
//    var getLon: String {
//        return "\(lastKnownLocation?.coordinate.longitude)"
//    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied{
            print("denied")
            LocationManager.permission = "denied"
        }
        else{
            print("athorized")
            manager.allowsBackgroundLocationUpdates = true
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager.requestLocation()
        }
    }
    
    func start() {
        //manager.requestAlwaysAuthorization()
        //manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
    }
    

    func requestLoc(){
        if(LocationManager.permission == "denied"){
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                       return
                   }

                   if UIApplication.shared.canOpenURL(settingsUrl) {
                       UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                           print("Settings opened: \(success)") // Prints true
                       })
                   }
        }
        else{
        manager.requestWhenInUseAuthorization()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func startUpdating() {
        self.manager.delegate = self
       // self.manager.requestAlwaysAuthorization()
       // self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
       // print(lastKnownLocation!.coordinate.latitude)
        
        if(lastKnownLocation!.coordinate.latitude != LocationManager.LMlat && lastKnownLocation!.coordinate.longitude != LocationManager.LMlong)
        {
            //manager.requestAlwaysAuthorization()
           
            //This fetches the users speed and coverts it to KM
            let km = String(format: "%.0f",lastKnownLocation!.speed * 3.6)
            LocationManager.Speed = Int(km) ?? 0
            //We then check to see if the users speed is above 2.5km and if so we update.
            //if(km > String(2.5)){
                print("Updating latest location")
                print("speed: \(km)")
                print(lastKnownLocation!.verticalAccuracy)
                print(lastKnownLocation!.horizontalAccuracy)
                LocationManager.LMlat = lastKnownLocation!.coordinate.latitude
                LocationManager.LMlong = lastKnownLocation!.coordinate.longitude
                updateServerLocation(latitude: LocationManager.LMlat, longitude:  LocationManager.LMlong, speed: km)
           // }
        }
        
        //Maybe Use in Future Version
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lastKnownLocation!.coordinate.latitude, longitude: lastKnownLocation!.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                // Place details
                guard let placeMark = placemarks?.first else { return }
                print(placeMark)
                // Location name
                if let locationName = placeMark.location {
                    print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    print(city)
                }
                // State
                if let state = placeMark.administrativeArea {
                    print(state)
                    print(UserSettings().state)
                    if UserSettings().state.isEmpty{
                        print("OOPS I ran")
                        UserSettings().state = state
                    }
                }
                // Zip code
                if let zip = placeMark.postalCode {
                    print(zip)
                }
               
                // Country
                if let country = placeMark.country {
                    print(country)
                    UserSettings().country = country
                }
                
        })
        
        
        
        //showLocation()
    }
    
    func updateServerLocation(latitude:Double,longitude:Double, speed:String)
    {
        let locationurl = URL(string: "https://api.drn1.com.au:9000/listener?uuid=\(MusicPlayer.uuid ?? "")&lat=\(latitude)&long=\(longitude)&speed=\(speed)")!
        //print(locationurl )
        // print("location: \(MusicPlayer.uuid ?? "") lat: \(latitude), long: \(longitude)")
         
          URLSession.shared.dataTask(with: locationurl) { (data, res, err) in
          DispatchQueue.main.async{
           // print("The Server should of updated")
            
              //  guard let data = data else { return }
                
            }
             return
        }.resume()
    }
    

//    func showLocation(){
//        print("From showLocation method")
//        print("Latitude: \(getLat)")
//        print("Longitude: \(getLon)")
//    }
    
    
}

