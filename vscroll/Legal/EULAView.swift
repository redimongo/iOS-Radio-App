//
//  TermsOfServiceView.swift
//  DRN1
//
//  Created by Russell Harrower on 02/5/21.
//  Copyright © 2021 Russell Harrower. All rights reserved.
//

import SwiftUI
import Flurry_iOS_SDK




struct EULAView: View {
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Licence").underline()
                Text("1) Under this End User Licence Agreement (the \"Agreement\"), Radio Media Pty Ltd (the \"Vendor\") grants to the user (the \"Licensee\") a non-exclusive and non-transferable licence (the \"Licence\") to use DRN1 (the \"Software\").\n\n2) \"Software\" includes the executable computer programs and any related printed, electronic and online documentation and any other files that may accompany the product.\n\n3) Title, copyright, intellectual property rights and distribution rights of the Software remain exclusively with the Vendor. Intellectual property rights include the look and feel of the Software. This Agreement constitutes a licence for use only and is not in any way a transfer of ownership rights to the Software.\n\n4)The rights and obligations of this Agreement are personal rights granted to the Licensee only. The Licensee may not transfer or assign any of the rights or obligations granted under this Agreement to any other person or legal entity. The Licensee may not make available the Software for use by one or more third parties.\n\n5)The Software may not be modified, reverse-engineered, or de-compiled in any manner through current or future available technologies.\n\n6)Failure to comply with any of the terms under the Licence section will be considered a material breach of this Agreement.\n\n")
                Text("Licence Fee").underline()
                Text("The original purchase price paid by the Licensee will constitute the entire licence fee and is the full consideration for this Agreement.\n\n")
                Text("Limitation of Liability").underline()
                Text("8) The Software is provided by the Vendor and accepted by the Licensee \"as is\". Liability of the Vendor will be limited to a maximum of the original purchase price of the Software. The Vendor will not be liable for any general, special, incidental or consequential damages including, but not limited to, loss of production, loss of profits, loss of revenue, loss of data, or any other business or economic disadvantage suffered by the Licensee arising out of the use or failure to use the Software.\n\n9)The Vendor makes no warranty expressed or implied regarding the fitness of the Software for a particular purpose or that the Software will be suitable or appropriate for the specific requirements of the Licensee.\n\n10)The Vendor does not warrant that use of the Software will be uninterrupted or error-free. The Licensee accepts that software in general is prone to bugs and flaws within an acceptable level as determined in the industry.\n\n ")
                Text("Warrants and Representations").underline()
                Text("11) The Vendor warrants and represents that it is the copyright holder of the Software. The Vendor warrants and represents that granting the licence to use this Software is not in violation of any other agreement, copyright or applicable statute.\n\n")
                
             }
            VStack(alignment: .leading){
                Text("Acceptance").underline()
                Text("12) All terms, conditions and obligations of this Agreement will be deemed to be accepted by the Licensee (\"Acceptance\") on installation of the Software.\n\n")
                Text("Terms").underline()
                Text("13) The term of this Agreement will begin on Acceptance and is perpetual.\n\n")
                Text("Termination").underline()
                Text("14) This Agreement will be terminated and the Licence forfeited where the Licensee has failed to comply with any of the terms of this Agreement or is in breach of this Agreement. On termination of this Agreement for any reason, the Licensee will promptly destroy the Software or return the Software to the Vendor.\n\n")
                Text("Force Majeure").underline()
                Text("15) The Vendor will be free of liability to the Licensee where the Vendor is prevented from executing its obligations under this Agreement in whole or in part due to Force Majeure, such as earthquake, typhoon, flood, fire, and war or any other unforeseen and uncontrollable event where the Vendor has taken any and all appropriate action to mitigate such an event.\n\n")
                Text("Governing Law").underline()
                Text("16) The Parties to this Agreement submit to the jurisdiction of the courts of the State of Western Australia for the enforcement of this Agreement or any arbitration award or decision arising from this Agreement. This Agreement will be enforced or construed according to the laws of the State of Western Australia.\n\n")
            }
            VStack(alignment: .leading){
                Text("Miscellaneous").underline()
                Text("17)This Agreement can only be modified in writing signed by both the Vendor and the Licensee\n\n18) This Agreement does not create or imply any relationship in agency or partnership between the Vendor and the Licensee.\n\n19) Headings are inserted for the convenience of the parties only and are not to be considered when interpreting this Agreement. Words in the singular mean and include the plural and vice versa. Words in the masculine gender include the feminine gender and vice versa. Words in the neuter gender include the masculine gender and the feminine gender and vice versa.\n\n20) If any term, covenant, condition or provision of this Agreement is held by a court of competent jurisdiction to be invalid, void or unenforceable, it is the parties' intent that such provision be reduced in scope by the court only to the extent deemed necessary by that court to render the provision reasonable and enforceable and the remainder of the provisions of this Agreement will in no way be affected, impaired or invalidated as a result.\n\n21) This Agreement contains the entire agreement between the parties. All understandings have been included in this Agreement. Representations which may have been made by any party to this Agreement may in some way be inconsistent with this final written Agreement. All such statements are declared to be of no value in this Agreement. Only the written terms of this Agreement will bind the parties.\n\n22) This Agreement and the terms and conditions contained in this Agreement apply to and are binding upon the Vendor's successors and assigns.\n\n")
                Text("Notices").underline()
                Text("23) All notices to the Vendor under this Agreement are to be provided at the following address:\nRadio Media Pty Ltd: 16/795 Beaufort Street, Mount Lawley, WA, 6050")
            }
            
        }
            .onAppear{
                //Send data to dataA
                Flurry.logEvent("End User Licence Agreement")
                //RUN CODE TO Fetch podcast episodes.
                
                
            }
            .navigationBarTitle("EULA", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
           
      
        
        
    
    }
        
}

