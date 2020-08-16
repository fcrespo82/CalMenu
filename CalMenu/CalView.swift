//
//  CalView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 14/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Combine
import SwiftUI

struct CalView: View {
    var cellSize: CGFloat = 20
    var calendar = Calendar.autoupdatingCurrent
    var date: Date

    var body: some View {
        var daysOfMonthByWeek: [[Int]] = []

        // Divide days into weeks easiyly
        _ = CalendarHelper.getDaysPadded(for: date).publisher
            .collect(7)
            .collect()
            .sink(receiveValue: { daysOfMonthByWeek = $0 })

        let currentDay = calendar.component(.day, from: date)

        return VStack(alignment: .leading) {
            VStack {
                Text(CalendarHelper.monthName(for: date))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(5)
                    .padding([.bottom], 5)
                HStack {
                    ForEach(calendar.veryShortWeekdaySymbols, id: \.self) { weekday in
                        Text(weekday)
                            .fontWeight(.bold)
                            .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
                            .padding(5)
                    }
                }.background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(5)
            }

            ForEach(0 ..< daysOfMonthByWeek.count, id: \.self) { array in
                HStack {
                    ForEach(daysOfMonthByWeek[array], id: \.self) { number in
                        Text(CalendarHelper.stringDay(for: number))
                            .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
                            .padding(5)
                            .background(number == currentDay ? Color(NSColor.controlAccentColor) : nil)
                            .cornerRadius(.infinity)
                            .foregroundColor(number == currentDay ? Color(NSColor.selectedTextColor) : Color(NSColor.textColor))
                    }
                }
            }
            HStack {
//                Button(action: {
//                    print("Open config")
//                }) {
//                    Text("Preferences")
//                        .padding(.horizontal)
//                }
                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .padding(.horizontal)
                }
            }
        }
        .padding(5)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct CalView_Previews: PreviewProvider {
    static var calendar = Calendar.autoupdatingCurrent

    static var previews: some View {
        Group {
            CalView(date: Date()).previewLayout(.fixed(width: 260, height: 191)).colorScheme(.light)

            CalView(date: Date()).previewLayout(.fixed(width: 260, height: 191))
                .colorScheme(.dark).environment(\.locale, .init(identifier: "en"))

            ForEach(1 ... 12, id: \.self) { month in
                CalView(date: calendar.date(from: DateComponents(year: 2020, month: month, day: 1))!).previewLayout(.fixed(width: 260, height: 191))
            }
        }
    }
}
