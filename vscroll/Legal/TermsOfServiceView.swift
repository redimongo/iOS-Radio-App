//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 30/4/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK




struct TermsOfServiceView: View {
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
               
                Text("These terms and conditions (the \"Terms and Conditions\") govern the use of www.drn1.com.au and any DRN1 Mobile/Tablet Application (the \"Site\"). This Site is owned and operated by Radio Media Pty Ltd. This Site is a news or media website.\n\nBy using this Site, you indicate that you have read and understand these Terms and Conditions and agree to abide by them at all times.\n\nTHESE TERMS AND CONDITIONS CONTAIN A DISPUTE RESOLUTION CLAUSE THAT IMPACTS YOUR RIGHTS ABOUT HOW TO RESOLVE DISPUTES. PLEASE READ IT CAREFULLY.\n\n")
                Text("Intellectual Property").underline()
                Text("All content published and made available on our Site is the property of Radio Media Pty Ltd and the Site's creators. This includes, but is not limited to images, text, logos, documents, downloadable files and anything that contributes to the composition of our Site.\n\n")
                Text("Acceptable Use").underline()
                Text("As a user of our Site, you agree to use our Site legally, not to use our Site for illegal purposes, and not to:\n\u{2022} Harass or mistreat other users of our Site;\n\u{2022} Violate the rights of other users of our Site;\n\u{2022} Violate the intellectual property rights of the Site owners or any third party to the Site;\n\u{2022} Hack into the account of another user of the Site;\n\u{2022} Act in any way that could be considered fraudulent; or\n\u{2022} Post any material that may be deemed inappropriate or offensive.\n\n If we believe you are using our Site illegally or in a manner that violates these Terms and Conditions, we reserve the right to limit, suspend or terminate your access to our Site. We also reserve the right to take any legal steps necessary to prevent you from accessing our Site.\n\n")
                Text("Accounts").underline()
                Text("When you create an account on our Site, you agree to the following:\n\n1) You are solely responsible for your account and the security and privacy of your account, including passwords or sensitive information attached to that account; and\n2) All personal information you provide to us through your account is up to date, accurate, and truthful and that you will update your personal information if it changes.\n\nWe reserve the right to suspend or terminate your account if you are using our Site illegally or if you violate these Terms and Conditions.\n\n")
                
            }
            VStack(alignment: .leading){
                Text("Links to Other Websites").underline()
                Text("Our Site contains links to third party websites or services that we do not own or control. We are not responsible for the content, policies, or practices of any third party website or service linked to on our Site. It is your responsibility to read the terms and conditions and privacy policies of these third party websites before using these sites.\n\n")
                Text("Limitation of Liability").underline()
                Text("Radio Media Pty Ltd and our directors, officers, agents, employees, subsidiaries, and affiliates will not be liable for any actions, claims, losses, damages, liabilities and expenses including legal fees from your use of the Site.\n\n")
                Text("Indemnity").underline()
                Text("Except where prohibited by law, by using this Site you indemnify and hold harmless Radio Media Pty Ltd and our directors, officers, agents, employees, subsidiaries, and affiliates from any actions, claims, losses, damages, liabilities and expenses including legal fees arising out of your use of our Site or your violation of these Terms and Conditions.\n\n")
                Text("Applicable Law").underline()
                Text("These Terms and Conditions are governed by the laws of the State of Western Australia.\n\n")
                Text("Dispute Resolution").underline()
                Text("Subject to any exceptions specified in these Terms and Conditions, if you and Radio Media Pty Ltd are unable to resolve any dispute through informal discussion, then you and Radio Media Pty Ltd agree to submit the issue before a mediator. The decision of the mediator will not be binding. Any mediator must be a neutral party acceptable to both you and Radio Media Pty Ltd.\n\nNotwithstanding any other provision in these Terms and Conditions, you and Radio Media Pty Ltd agree that you both retain the right to bring an action in small claims court and to bring an action for injunctive relief or intellectual property infringement.\n\n")
            }
            VStack(alignment: .leading){
                Text("Severability").underline()
                Text("If at any time any of the provisions set forth in these Terms and Conditions are found to be inconsistent or invalid under applicable laws, those provisions will be deemed void and will be removed from these Terms and Conditions. All other provisions will not be affected by the removal and the rest of these Terms and Conditions will still be considered valid.\n\n")
                Text("Changes").underline()
                Text("These Terms and Conditions may be amended from time to time in order to maintain compliance with the law and to reflect any changes to the way we operate our Site and the way we expect users to behave on our Site. We will notify users by email of changes to these Terms and Conditions or post a notice on our Site.\n\n")
                Text("Contact Details").underline()
                Text("email: admin@drn1.com.au\n\nAddress: 16/795 Beaufort Street, Mount Lawley, WA, 6050\n\nYou can also contact us through the feedback form available on our Site.\n\n\n\nEffective Date: 1st day of May, 2021\n©2002-2021 LawDepot.com®")
            }
            
        }
            .onAppear{
                //Send data to dataA
                Flurry.logEvent("Terms_of_Services")
                //RUN CODE TO Fetch podcast episodes.
                
                
            }
            .navigationBarTitle("TERMS AND CONDITIONS", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
           
      
        
        
    
    }
        
}

