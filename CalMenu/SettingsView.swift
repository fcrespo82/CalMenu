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
    
    @State var automaticallyCheckForUpdates = UserDefaults.standard.bool(forKey: DEFAULTS_CHECK_FOR_UPDATE_KEY)
    
    @State var dismiss: (() -> Void)!
    
    // Not sure this is the best way of doing it
    var presentingWindow: NSWindow!
    
    var body: some View {
        let launchOnBootBinding = Binding(
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
        
        let checkForUpdateBinding = Binding(
            get: {
                return self.automaticallyCheckForUpdates
            },
            set: {
                UserDefaults.standard.set($0, forKey: DEFAULTS_CHECK_FOR_UPDATE_KEY)
                self.automaticallyCheckForUpdates = $0
            }
        )
        VStack {
            TabView {
                VStack {
                    HStack {
                        Text("Toggle Calendar View:")
                        KeyboardShortcuts.Recorder(for: .toggleCalendarView)
                    }
                    Toggle(isOn: launchOnBootBinding) {
                        Text("Launch on startup")
                    }
                }
                .padding()
                .tabItem {
                    Text("General")
                }
                VStack {
                    Button(action: {
                        checkForUpdates()
                    }, label: {
                        Text("Check for updates")
                    })
                    Toggle(isOn: checkForUpdateBinding) {
                        Text("Check for updates automatically")
                    }
                }
                .padding()
                .tabItem {
                    Text("Updates")
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    self.presentingWindow.close()
                }, label: {
                    Text("Close")
                })
            }
        }
        .frame(width: 400, height: 150, alignment: .center)
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
