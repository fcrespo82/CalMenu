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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        date = Date()
    }

    var body: some View {
        let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: date)
        return VStack {
            HStack(spacing: 0) {
                Button(action: {
                    date = date.advanced(by: -.oneMonth)
                }) {
                    Text("􀄪")
                }
                Spacer()
                Text(CalendarHelper.monthName(for: date, locale: locale))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(5)
                    .onTapGesture(count: 1, perform: {
                        date = Date()
                    })
                Spacer()
                Button(action: {
                    date = date.advanced(by: .oneMonth)
                }) {
                    Text("􀄫")
                }
            }
            WeekHeaderView()
            ForEach(daysOfMonthByWeek.indices, id: \.self) { week in
                HStack(spacing: 0) {
                    WeekView(week: .constant(daysOfMonthByWeek[week]))
//                    Text("\(week)")
                }
            }
            Spacer()
            HStack {
//                Button(action: {
//                    self.showPreferences()
//                }) {
//                    Text("Preferences")
//                        .padding(.horizontal, 5)
//                }
                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .padding(.horizontal, 5)
                }
            }
        }
        .frame(width: 210, height: 280, alignment: .top)
        .padding(10)
    }

    func showPreferences() {
        let hostingController = NSHostingController(rootView: PrefsView(text: .constant("Test")))
        let window = NSWindow(contentViewController: hostingController)
        window.toolbar = NSToolbar()
        window.title = "Preferences"
//        window.setContentSize(NSSize(width: 500, height: 200))
        window.makeKeyAndOrderFront(nil)
        window.makeMain()
    }
}

struct CalView_Previews: PreviewProvider {
    static var calendar = Calendar.autoupdatingCurrent

    static var previews: some View {
        Group {
            CalView().colorScheme(.light)
            CalView().colorScheme(.dark).environment(\.locale, .init(identifier: "en"))
        }.environment(\.locale, .init(identifier: "pt-br"))
    }
}
