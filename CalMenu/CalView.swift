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
    var date: Date
    @Environment(\.calendar) var calendar
    @Environment(\.locale) var locale

    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale

        let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: self.date)

        return VStack {
            VStack(spacing: 0) {
                Text(CalendarHelper.monthName(for: date, locale: locale))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(5)
                    .padding([.bottom], 5)
                HStack(spacing: 0) {
                    ForEach(dateFormatter.veryShortWeekdaySymbols, id: \.self) { weekday in
                        Text(weekday)
                            .fontWeight(.bold)
                            .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
                            .padding(5)
                    }
                }
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(5)
            }
            ForEach(0 ..< daysOfMonthByWeek.count, id: \.self) { week in
                HStack(spacing: 0) {
                    WeekView(week: daysOfMonthByWeek[week])
                }
            }
            HStack {
                Button(action: {
                    print("Open config")
                }) {
                    Text("Preferences")
                        .padding(.horizontal, 5)
                }

                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .padding(.horizontal, 5)
                }
            }
        }
        .frame(width: 210, height: 290, alignment: .center)
        .padding(10)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct CalView_Previews: PreviewProvider {
    static var calendar = Calendar.autoupdatingCurrent

    static var previews: some View {
        Group {
            CalView(date: Date()).previewLayout(.fixed(width: 260, height: 191)).colorScheme(.light).environment(\.locale, .init(identifier: "pt-br"))

            CalView(date: Date()).previewLayout(.fixed(width: 260, height: 191))
                .colorScheme(.dark).environment(\.locale, .init(identifier: "en"))
//
//            ForEach(1 ... 12, id: \.self) { month in
//                CalView(date: calendar.date(from: DateComponents(year: 2020, month: month, day: 3))!).previewLayout(.fixed(width: 260, height: 191))
//            }
        }
    }
}
