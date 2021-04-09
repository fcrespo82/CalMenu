//
//  UpdateTab.swift
//  CalMenu
//
//  Created by Fernando Crespo on 09/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct UpdateTab: View {
    @State var automaticallyCheckForUpdates = UserDefaults.standard.bool(forKey: DEFAULTS_CHECK_FOR_UPDATE_KEY)

    var body: some View {
        let checkForUpdateBinding = Binding(
            get: {
                self.automaticallyCheckForUpdates
            },
            set: {
                UserDefaults.standard.set($0, forKey: DEFAULTS_CHECK_FOR_UPDATE_KEY)
                self.automaticallyCheckForUpdates = $0
            }
        )

        GroupBox {
            VStack {
                Spacer()
                HStack {
                    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    Text("Version:")
                    Text(appVersion!)
                }
                Spacer()
                Button(action: {
                    checkForUpdates()
                }, label: {
                    Text("Check for updates")
                })
                Toggle(isOn: checkForUpdateBinding) {
                    Text("Check for updates automatically")
                }
                Spacer()
            }
            .padding()
        }
        .padding([.leading, .trailing], 5)
    }
}

struct UpdateTab_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTab()
    }
}
