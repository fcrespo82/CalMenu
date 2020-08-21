//
//  AppDelegate.swift
//  CalMenu
//
//  Created by Fernando Crespo on 14/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Cocoa
import HotKey
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    var statusBarItem: NSStatusItem!
    let popover = NSPopover()
    let showPopoverHotKey = HotKey(key: .c, modifiers: [.command, .option])

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createStatusBarMenu()
        showPopoverHotKey.keyDownHandler = {
            self.togglePopover(nil)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func createStatusBarMenu() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusBarItem.button {
            button.title = "🗓"
            button.action = #selector(togglePopover(_:))
        }
        popover.behavior = .transient
    }

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }

    func showPopover(sender: Any?) {
        if let button = statusBarItem.button {
            popover.contentViewController = NSHostingController(rootView: CalView())
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

    func closePopover(sender: Any?) {
        popover.performClose(sender)
        popover.contentViewController = nil
    }
}
