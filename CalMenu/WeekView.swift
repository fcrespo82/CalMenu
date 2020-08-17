//
//  WeekView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct WeekView: View {
    var cellSize: CGFloat = 20
    var week: [(day: Int, dimmed: Bool, selected: Bool)]
    var body: some View {
        HStack(spacing: 0) {
            ForEach(week, id: \.day) { item in
                DayView(day: item.day, dimmed: item.dimmed, selected: item.selected)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: Date())

    static var previews: some View {
        WeekView(week: daysOfMonthByWeek[0])
    }
}
