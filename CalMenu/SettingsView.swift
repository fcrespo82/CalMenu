//
//  PrefsView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI
import Foundation
import KeyboardShortcuts

struct SettingsView: View {
    @State var text: String!
        
    @State var isRegistered = UserDefaults.standard.bool(forKey: DEFAULTS_LAUNCH_ON_BOOT_KEY)
        
    @State var dismiss: (() -> Void)!
    
    // Not sure this is the best way of doing it
    var window: NSWindow!
    
    var body: some View {
        
        let binding = Binding(
            get: {
                return self.isRegistered
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
        
        TabView {
            VStack() {
                Spacer()
                HStack {
                    Text("Toggle Calendar View")
                    KeyboardShortcuts.Recorder(for: .toggleCalendarView)
                }
                Toggle(isOn: binding) {
                    Text("Launch on startup")
                }
                Button(action: {
                    checkForUpdates()
                }, label: {
                    Text("Check for updates")
                })
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.window.close()
                    }, label: {
                        Text("Close")
                    })
                }
            }.tabItem {
                Text("General") //, systemImage: "gear")
            }
            
        }
        .frame(width: 400, height: 200, alignment: .center)
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
