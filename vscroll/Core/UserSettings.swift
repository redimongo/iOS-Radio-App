//
//  UserSettings.swift
//  DRN1
//
//  Created by Russell Harrower on 30/4/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//


import Foundation
import Flurry_iOS_SDK
import Combine

class UserSettings: ObservableObject {
    @Published var lockDOB: Int {
        didSet {
            UserDefaults.standard.set(lockDOB, forKey: "lockDOB")
        }
    }
    
    
    @Published var firstname: String {
        didSet {
            UserDefaults.standard.set(firstname, forKey: "firstname")
        }
    }
    
    @Published var lastname: String {
        didSet {
            UserDefaults.standard.set(lastname, forKey: "lastname")
        }
    }
    
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    
    @Published var mobile: String {
        didSet {
            UserDefaults.standard.set(mobile, forKey: "mobile")
        }
    }
    
    @Published var state: String {
        didSet {
            UserDefaults.standard.set(state, forKey: "state")
        }
    }
    
    @Published var country: String {
        didSet {
            UserDefaults.standard.set(country, forKey: "country")
        }
    }
    
    @Published var dateofbirth: Date {
        didSet {
            UserDefaults.standard.set(dateofbirth, forKey: "dateofbirth")
            let ageComponents = Calendar.current.dateComponents([.year],
                                                    from: dateofbirth,
                                                    to: Date())
            let age = Int32(ageComponents.year!)
            UserSettings().age = age
            }
    }
    
    @Published var age: Int32 {
        didSet {
            UserDefaults.standard.set(age, forKey: "age")
        }
    }
    
    @Published var favStation: String {
        didSet {
            UserDefaults.standard.set(favStation, forKey: "favStation")
        }
    }
    
   
    public var favStations = ["DRN1", "DRN1 Hits", "DRN1 United", "DRN1 Life", "DRN1 Dance"]
        
    
    @Published var gender: String {
        didSet {
            UserDefaults.standard.set(gender, forKey: "gender")
        }
    }
    
   
    public var genders = ["Male", "Female", "Intersex/unspecified", "NA"]
      
    
    @Published var petrolType: String {
        didSet {
            UserDefaults.standard.set(petrolType, forKey: "petrolType")
           
        }
    }
    
   
    public var petrolTypes = ["91", "95", "98", "LPG", "Diesel"]
      
    
    
    /* LOCATION BASED INFO */
    
    
    @Published var lat: Double {
        didSet {
            UserDefaults.standard.set(lat, forKey: "lat")
        }
    }
    
    @Published var long: Double {
        didSet {
            UserDefaults.standard.set(long, forKey: "long")
        }
    }
    
    /* Win Pages */

    @Published var lockRequest: Date {
        didSet {
            UserDefaults.standard.set(lockRequest, forKey: "lockRequest")
        }
    }
    
    @Published var lockFunny: Date {
        didSet {
            UserDefaults.standard.set(lockFunny, forKey: "lockFunny")
        }
    }
    
    /* END Win Pages */
    
    
    init() {
        self.firstname = UserDefaults.standard.object(forKey: "firstname") as? String ?? ""
        self.lastname = UserDefaults.standard.object(forKey: "lastname") as? String ?? ""
        self.email = UserDefaults.standard.object(forKey: "email") as? String ?? ""
        self.mobile = UserDefaults.standard.object(forKey: "mobile") as? String ?? ""
        self.state = UserDefaults.standard.object(forKey: "state") as? String ?? ""
        self.country = UserDefaults.standard.object(forKey: "country") as? String ?? ""
        self.dateofbirth = UserDefaults.standard.object(forKey: "dateofbirth") as? Date ?? Date(timeIntervalSinceNow: 0)
        self.age = UserDefaults.standard.object(forKey: "age") as? Int32 ?? 0
        
        self.favStation = UserDefaults.standard.object(forKey: "favStation") as? String ?? "DRN1"
        self.gender = UserDefaults.standard.object(forKey: "gender") as? String ?? "NA"
        self.petrolType = UserDefaults.standard.object(forKey: "petrolType") as? String ?? "91"
        self.lockDOB = UserDefaults.standard.object(forKey: "lockDOB") as? Int ?? 0
        self.lockRequest = UserDefaults.standard.object(forKey: "lockRequest") as? Date ?? Date(timeIntervalSince1970: 0)
        self.lockFunny = UserDefaults.standard.object(forKey: "lockFunny") as? Date ?? Date(timeIntervalSince1970: 0)
        
        self.lat = UserDefaults.standard.object(forKey: "lat") as? Double ?? 0.0
        self.long = UserDefaults.standard.object(forKey: "long") as? Double ?? 0.0

    }
}
