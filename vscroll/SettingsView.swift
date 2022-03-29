import Foundation
import Combine
import SwiftUI
import Flurry_iOS_SDK
import AVKit
import AdSupport


struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()

    
    var locked: String{
        return "\(userSettings.lockDOB)"
    }
    
   
    
    var body: some View {
    NavigationView{
            Form {
                Section(header: Text("Your Profile")) {
                    if (userSettings.lockDOB == 0){
                        TextField("First Name", text: $userSettings.firstname)
                    }
                    else{
                        TextField("First Name", text: $userSettings.firstname).disabled(true)
                    }
                    
                    if (userSettings.lockDOB == 0){
                        TextField("Last Name", text: $userSettings.lastname)
                    }
                    else{
                        TextField("Last Name", text: $userSettings.lastname).disabled(true)
                    }
                    
                    if (userSettings.lockDOB == 0){
                        TextField("Email Address", text: $userSettings.email)
                    }
                    else{
                        TextField("Email Address", text: $userSettings.email).disabled(true)
                    }
                    if (userSettings.lockDOB == 0){
                        TextField("Mobile", text: $userSettings.mobile)
                    }
                    else{
                        TextField("Mobile", text: $userSettings.mobile).disabled(true)
                    }
                    
                    
                    if (userSettings.lockDOB == 0){
                        DatePicker(LocalizedStringKey("D.O.B"),selection: $userSettings.dateofbirth,in: ...Date(),
                                   displayedComponents: .date)
                            
                            
                    }
                    else{
                        DatePicker(LocalizedStringKey("D.O.B"),selection: $userSettings.dateofbirth,in: ...Date(),
                                   displayedComponents: .date).disabled(true)
                    }
                    
                    if(userSettings.lockDOB == 0){
                        Picker(selection: $userSettings.gender, label: Text("Gender")) {
                                        ForEach(userSettings.genders, id: \.self) { gender in
                                                 Text(gender)
                                             }
                        }
                    }else
                    {
                        Picker(selection: $userSettings.gender, label: Text("Gender")) {
                                        ForEach(userSettings.genders, id: \.self) { gender in
                                                 Text(gender)
                                             }
                        }.disabled(true)
                    }
                    
                    VStack{
                        HStack {
                        Text("State: ")
                        TextField("", text: $userSettings.state)
                                .disabled(true)
                        Text("Country: ")
                        TextField("", text: $userSettings.country)
                                .disabled(true)
                        }
                        //Text("State and Country are pre-filled by using your GEO location service - we only check this once.").font(.system(size: 12))
                       
                    }
                    
                    
                       /* Text("The above is optional, but by filling out this section you will save time when entering competitions as this information will autofill. This data will not be transferred to DRN1 servers unless entering a competition.").font(.system(size: 12))*/

                    if(userSettings.lockDOB == 0){
                    Button("Save Profile") {
                                userSettings.lockDOB = 1
                               // LocationManager.permission = "denied"
                    }.foregroundColor(.green)
                    }
                }
                Section(header: Text("Station")) {
                        Picker(selection: $userSettings.favStation, label: Text("Favourite Station")) {
                                        ForEach(userSettings.favStations, id: \.self) { favStation in
                                                Text(favStation)
                                            }
                                        }
                        Text("By selecting your favourite station, when the app launches it will automaticlly start playing the station you have selected above.\n\nNote: This wont come into effect until you restart the app.").font(.system(size: 12))
                }
                
               Section(header: Text("Car Settings")) {
                        Picker(selection: $userSettings.petrolType, label: Text("Fuel Type")) {
                                        ForEach(userSettings.petrolTypes, id: \.self) { petrol in
                                                Text(petrol)
                                            }
                                        }
                        Text("The following will be used to provide you with the latest fuel prices for your car. (Availble on Selected stations only)").font(.system(size: 12))
                }

                Section(header: Text("Device ID")) {
                    Text(UIDevice.current.identifierForVendor?.uuidString ?? "").font(.system(size: 12))
                }
                
                Section(header: Text("Advertising ID")) {
                    Text(ASIdentifierManager.shared().advertisingIdentifier.uuidString ).font(.system(size: 12))
                }
                
                Section(header: Text("Legal")) {
                        List{
                            NavigationLink(destination: TermsOfServiceView()) {
                                Text("Terms of Service")
                               }
                            NavigationLink(destination: EULAView()) {
                                  Text("EULA")
                                 }
                     
                            NavigationLink(destination: PrivacyPolicyView()) {
                                Text("Privacy Policy")
                               }
                            }
                }
                
               // Text(locked)
                Button("Reset Profile") {
                            userSettings.lockDOB = 0
                            //UserDefaults.standard.reset()
                            print("Image tapped!")
                           
                           // LocationManager.permission = "denied"
                }
                Text("By reseting your profile, you may not be able to access parts of the app like you did before.").font(.system(size: 12))
               
        }
        
            
            .navigationBarTitle("Settings", displayMode: .inline)
            
        }.navigationViewStyle(StackNavigationViewStyle())
   }//.navigationBarTitle(Text("Settings"), displayMode: .inline)
   
   

}




extension UserDefaults {

    enum Keys: String, CaseIterable {

        case state
        case username
        case dateofbirth
        case favStation
        case gender
        case petrolType
        case lockDOB
    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}


