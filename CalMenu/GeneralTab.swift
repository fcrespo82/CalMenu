//
//  GeneralTab.swift
//  CalMenu
//
//  Created by Fernando Crespo on 09/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import KeyboardShortcuts
import SwiftUI

struct GeneralTab: View {
    @State var isRegistered = UserDefaults.standard.bool(forKey: DEFAULTS_LAUNCH_ON_BOOT_KEY)

    var body: some View {
        let launchOnBootBinding = Binding(
            get: {
                self.isRegistered
            },
            set: {
                UserDefaults.standard.set($0, forKey: DEFAULTS_LAUNCH_ON_BOOT_KEY)
                self.isRegistered = $0
                if self.isRegistered {
                    registerLoginItem()
                } else {
                    registerLoginItem(false)
                }
            }
        )

        GroupBox {
            VStack {
                Spacer()
                HStack {
                    Text("Toggle calendar view:")
                    KeyboardShortcuts.Recorder(for: .toggleCalendarView)
                }
                Toggle(isOn: launchOnBootBinding) {
                    Text("Launch on startup")
                }
                Spacer()
            }
            .padding()
        }
        .padding([.leading, .trailing], 5)
    }
}

struct GeneralTab_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTab()
    }
}
