//
//  LauncherHelper.swift
//  CalMenu
//
//  Created by Fernando Crespo on 17/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Cocoa
import Foundation
import ServiceManagement

let LAUNCHER_APP_IDENTIFIER = "br.com.crespo.CalMenu.Launcher"
let MAIN_APP_IDENTIFIER = "br.com.crespo.CalMenu"
let KILL_LAUNCHER_NOTIFICATION_NAME = "br.com.crespo.CalMenu.killLauncher"
let DEFAULTS_LAUNCH_ON_BOOT_KEY = "launchOnStartUp"

extension Notification.Name {
    static let killLauncher = Notification.Name(KILL_LAUNCHER_NOTIFICATION_NAME)
}

func registerLoginItem(_ register: Bool = true) {
    
    SMLoginItemSetEnabled(LAUNCHER_APP_IDENTIFIER as CFString, register)
    
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == LAUNCHER_APP_IDENTIFIER }.isEmpty
    
    if isRunning {
        DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }
}

func isRegistered() -> Bool {
    return UserDefaults.standard.bool(forKey: DEFAULTS_LAUNCH_ON_BOOT_KEY)
}

extension AppDelegate {
    
    @objc func terminate() {
        NSApplication.shared.terminate(nil)
    }
    
    func runMainApp() {
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == MAIN_APP_IDENTIFIER }.isEmpty
        
        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(terminate), name: .killLauncher, object: MAIN_APP_IDENTIFIER)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("CalMenu") // main app name
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared.launchApplication(newPath)
        } else {
            terminate()
        }
    }
}
