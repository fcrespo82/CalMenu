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
                        if #available(OSX 11.0, *) {
                            Image(systemName: "arrow.left")
                        } else {
                            Text("←")
                        }
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
                        if #available(OSX 11.0, *) {
                            Image(systemName: "arrow.right")
                        } else {
                            Text("→")
                        }
                    }
                }
                WeekHeaderView()
                ForEach(daysOfMonthByWeek.indices, id: \.self) { week in
                    WeekView(week: .constant(daysOfMonthByWeek[week]))
                }
                HStack {
                    Button(action: {
                        if let delegate = NSApp.delegate as? AppDelegate {
                            delegate.showSettingsWindow(self)
                        }
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
}

struct CalView_Previews: PreviewProvider {
    static var calendar = Calendar.autoupdatingCurrent

    static var previews: some View {
        Group {
            CalView()
                .background(Color(NSColor.windowBackgroundColor))
                .colorScheme(.light)
            CalView()
                .background(Color(NSColor.windowBackgroundColor))
                .colorScheme(.dark)
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
