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
        manager.distanceFilter = 1
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
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lastKnownLocation!.coordinate.latitude, longitude: lastKnownLocation!.coordinate.longitude)
       
        
       /* let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: -32.16248149, longitude: 115.80723687), radius: 5, identifier: "DRN1Location")
                region.notifyOnExit = true
                region.notifyOnEntry = true
                manager.startMonitoring(for: region)*/
        
        
        
        let coordinate0 = CLLocation(latitude: lastKnownLocation!.coordinate.latitude, longitude: lastKnownLocation!.coordinate.longitude)
        let coordinate1 = CLLocation(latitude: LocationManager.LMlat, longitude: LocationManager.LMlong)

        let distanceInMeters = coordinate0.distance(from: coordinate1)
        
        if(distanceInMeters <= 500)
            {
                let s =   String(format: "%.2f", distanceInMeters)
                print( s + " Meters")
                //LocationManager.LMlat = lastKnownLocation!.coordinate.latitude
                //LocationManager.LMlong = lastKnownLocation!.coordinate.longitude
            }
            else
            {
                let s =   String(format: "%.2f", distanceInMeters)
                print("more than a mile" + s + " Miles")
                let km = String(format: "%.0f",lastKnownLocation!.speed * 3.6)
                LocationManager.Speed = Int(km) ?? 0
                LocationManager.LMlat = lastKnownLocation!.coordinate.latitude
                LocationManager.LMlong = lastKnownLocation!.coordinate.longitude
                updateServerLocation(latitude: LocationManager.LMlat, longitude:  LocationManager.LMlong, speed: km)
            }
        
      
        
        //Maybe Use in Future Version
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                // Place details
                guard let placeMark = placemarks?.first else { return }
               // print(placeMark)
                // Location name
                /* if let locationName = placeMark.location {
                   // print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                   // print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                   // print(city)
                }*/
                // State
                if let state = placeMark.administrativeArea {
                    print(state)
                    //print(UserSettings().state)
                    if UserSettings().state.isEmpty || UserSettings().state != state{
                       UserSettings().state = state
                    }
                }
                /*
                // Zip code
                if let zip = placeMark.postalCode {
                    
                    print(zip)
                }*/
               
                // Country
                if let country = placeMark.country {
                    print(country)
                    if UserSettings().country.isEmpty || UserSettings().country != country{
                        UserSettings().country = country
                    }
                    
                }
                
        })
        
        
        
        //showLocation()
    }
    
    
    /*func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        // User has exited from ur regiom
        print("USER HAS EXITED THE AREA\(lastKnownLocation!.coordinate.latitude) + \(lastKnownLocation!.coordinate.longitude)")
        
       // UserSettings().lat = lastKnownLocation!.coordinate.latitude
       // UserSettings().long = lastKnownLocation!.coordinate.longitude
    
        LocationManager.LMlat = lastKnownLocation!.coordinate.latitude
        LocationManager.LMlong = lastKnownLocation!.coordinate.longitude
        updateServerLocation(latitude: LocationManager.LMlat, longitude:  LocationManager.LMlong, speed: km)
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // User has ENTER from ur region
        print("USER IS INSIDE THE AREA \(lastKnownLocation!.coordinate.latitude) + \(lastKnownLocation!.coordinate.longitude)")
        
     }*/
    
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

