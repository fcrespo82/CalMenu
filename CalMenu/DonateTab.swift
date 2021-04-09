//
//  DonateTab.swift
//  CalMenu
//
//  Created by Fernando Crespo on 09/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct DonateTab: View {
    var body: some View {
        GroupBox {
            VStack {
                Spacer()
                if #available(OSX 11.0, *) {
                    Link("Donate to my open source projects", destination: URL(string: "https://www.paypal.com/donate?hosted_button_id=73E3UAJNR2VM4")!)
                } else {
                    Text("Donate to my open source projects")
                    Text("https://www.paypal.com/donate?hosted_button_id=73E3UAJNR2VM4")
                }
                Spacer()
            }
            .padding()
        }
        .padding([.leading, .trailing], 5)
    }
}

struct DonateTab_Previews: PreviewProvider {
    static var previews: some View {
        DonateTab()
    }
}
