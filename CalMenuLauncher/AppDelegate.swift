//
//  AppDelegate.swift
//  CalMenuLauncher
//
//  Created by Fernando Crespo on 17/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        runMainApp()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
