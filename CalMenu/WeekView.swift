//
//  WeekView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct WeekView: View {
    var week: [DayInfo]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(week) { item in
                DayView(dayInfo: item)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static let calendar = Calendar.autoupdatingCurrent
    static let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: calendar.date(byAdding: DateComponents(month: 1), to: Date())!)

    static var previews: some View {
        Group {
            WeekView(week: daysOfMonthByWeek[0])
            WeekView(week: daysOfMonthByWeek[0])
                .background(Color(NSColor.windowBackgroundColor))
                .colorScheme(.dark)
        }
    }
}
