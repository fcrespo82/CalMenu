//
//  AppDelegate.swift
//  CalMenu
//
//  Created by Fernando Crespo on 14/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Cocoa
import KeyboardShortcuts
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    var statusBarItem: NSStatusItem!
    let popover = NSPopover()
    var window: NSWindow!
    private static var selectedTab: Toolbar.Tab.Id = .general
    let selectedTabBinding = Binding(
        get: {
            AppDelegate.selectedTab
        },
        set: {
            AppDelegate.selectedTab = $0
        }
    )

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createStatusBarMenu()
        createSettingsWindow()
        KeyboardShortcuts.onKeyUp(for: .toggleCalendarView) { [self] in
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

    func createSettingsWindow() {
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 400), styleMask: [.closable, .titled], backing: .buffered, defer: true)

        // Do not release the window when closed clearing the variable and not working anymore
        window.isReleasedWhenClosed = false

        guard let window = window else { return }
        window.contentView = NSHostingView(rootView: SettingsView())
//        // Create the titlebar accessory
//        let titlebarAccessoryView = ToolbarView(selectedTab: selectedTabBinding)
//            .edgesIgnoringSafeArea(.top)
//            .padding([.top, .bottom], 40)
        ////            .padding(.bottom,-8.0)
//
//        let accessoryHostingView = NSHostingView(rootView:titlebarAccessoryView)
//        accessoryHostingView.frame.size = accessoryHostingView.fittingSize
//        let titlebarAccessory = NSTitlebarAccessoryViewController()
//        titlebarAccessory.view = accessoryHostingView
//
//        window.addTitlebarAccessoryViewController(titlebarAccessory)
        if #available(OSX 11.0, *) {
            window.titlebarSeparatorStyle = .none
            window.titlebarAppearsTransparent = true
        } else {
            // Fallback on earlier versions
        }
        window.title = NSLocalizedString("Settings", comment: "Settings String")
        window.center()
        window.setFrameAutosaveName("Settings Window")
    }

    func showSettingsWindow(_ sender: Any?) {
        guard let window = window else { return }
        // The application does not appear in the Dock and does not have a menu bar, but it may be activated programmatically or by clicking on one of its windows.
        NSApp.setActivationPolicy(.accessory)

        // If line bellow is not set the app cannot bring the window to the front of all apps.
        NSApp.activate(ignoringOtherApps: true)

        if !window.isVisible {
            window.makeKeyAndOrderFront(sender)
        }
    }

    func closeSettingsWindow(_ sender: Any?) {
        guard let window = window else { return }
        window.performClose(sender)
    }
}
