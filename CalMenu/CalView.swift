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
                    VStack {
                        Text(CalendarHelper.monthName(for: date, locale: locale))
                            .font(.headline)
                            .fontWeight(.bold).padding(.bottom, 5)
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
                }.frame(maxWidth: 210)
                WeekHeaderView()
                ForEach(daysOfMonthByWeek.indices, id: \.self) { week in
                    WeekView(week: .constant(daysOfMonthByWeek[week]))
                }

                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .padding(.horizontal, 5)
                }
            }
            .padding(5)
    }

    func showPreferences() {
        let hostingController = NSHostingController(rootView: PrefsView(text: .constant("Test")))
        let window = NSWindow(contentViewController: hostingController)
        window.toolbar = NSToolbar()
        window.title = "Preferences"
        window.setContentSize(NSSize(width: 500, height: 200))
        window.makeKeyAndOrderFront(self)
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
        }.environment(\.locale, .init(identifier: "pt-br"))
    }
}
