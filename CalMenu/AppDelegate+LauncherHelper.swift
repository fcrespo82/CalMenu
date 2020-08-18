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

extension Notification.Name {
    static let killLauncher = Notification.Name("br.com.crespo.CalMenu.killLauncher")
}

extension AppDelegate {
    func registerLogin() {
        let launcherAppId = "br.com.crespo.CalMenuLauncher"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty

        SMLoginItemSetEnabled(launcherAppId as CFString, true)

        if isRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
        }
    }

    @objc func terminate() {
        NSApplication.shared.terminate(nil)
    }

    func runMainApp() {
        let mainAppIdentifier = "br.com.crespo.CalMenu"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(terminate), name: .killLauncher, object: mainAppIdentifier)

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
