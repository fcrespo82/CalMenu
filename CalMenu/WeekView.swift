//
//  WeekView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct WeekView: View {
    @Binding var week: [(day: Int, dimmed: Bool, selected: Bool)]

    var body: some View {
        HStack(spacing: 0) {

            ForEach(week.indices, id: \.self) { item in
                DayView(day: self.$week[item].day, dimmed: self.$week[item].dimmed, selected: self.$week[item].selected)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static let daysOfMonthByWeek = CalendarHelper.getDaysPadded(for: Date().advanced(by: 60*60*24*30))

    static var previews: some View {
        WeekView(week: .constant(daysOfMonthByWeek[0]))
//        WeekView(week: daysOfMonthByWeek[1])
//        WeekView(week: daysOfMonthByWeek[2])
//        WeekView(week: daysOfMonthByWeek[3])
//        WeekView(week: daysOfMonthByWeek[4])
    }
}
