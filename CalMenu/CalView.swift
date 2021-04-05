//
//  CalView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 14/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Combine
import ServiceManagement
import SwiftUI

struct CalView: View {
    var cellSize: CGFloat = 20
    @State private var date: Date! = Date()
    @Environment(\.calendar) var calendar
    @Environment(\.locale) var locale

    init() {
        date = Date()
    }
    
    var body: some View {
        let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: date)
        return
            VStack(alignment: .trailing) {
                HStack {
                    Button(action: {
                        self.date = self.date.advanced(by: -.oneMonth)
                    }) {
                        Text("←")
                    }
                    VStack(alignment: .center, spacing: 5) {
                        Text(CalendarHelper.monthName(for: date, locale: locale))
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                        Text(CalendarHelper.year(for: date, locale: locale))
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture(count: 1, perform: {
                        self.date = Date()
                    })
                    Button(action: {
                        self.date = self.date.advanced(by: .oneMonth)
                    }) {
                        Text("→")
                    }
                }
                WeekHeaderView()
                ForEach(daysOfMonthByWeek.indices, id: \.self) { week in
                    WeekView(week: .constant(daysOfMonthByWeek[week]))
                }
                HStack {
                    Button(action: {
                        showSettings()
                    }) {
                        Text("Settings").padding(.horizontal, 5)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        NSApplication.shared.terminate(nil)
                    }) {
                        Text("Quit")
                            .padding(.horizontal, 5)
                            .fixedSize()
                    }
                }
            }
            .fixedSize()
            .padding(5)
    }
    
    func showSettings() {
        NSApp.setActivationPolicy(.regular)
        // If line bellow is not set the app cannot bring the window to the front of all apps.
        NSApp.activate(ignoringOtherApps: true)

        let window: NSWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 200), styleMask: [.closable, .miniaturizable, .resizable, .titled], backing: .buffered, defer: true)
        
        let hostingController = NSHostingController(rootView: SettingsView(presentingWindow: window))
                
        window.contentViewController = hostingController
        window.title = NSLocalizedString("Settings", comment: "Settings String")
        window.center()
        window.setFrameAutosaveName("Settings Window")
        window.makeKeyAndOrderFront(nil)
    }
}

struct CalView_Previews: PreviewProvider {
    static var calendar = Calendar.autoupdatingCurrent
    
    static var previews: some View {
        Group {
            CalView().colorScheme(.light)
            CalView()
                .background(Color(NSColor.windowBackgroundColor))
                .colorScheme(.dark)
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
