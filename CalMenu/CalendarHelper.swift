//
//  CalendarHelper.swift
//  CalMenu
//
//  Created by Fernando Crespo on 15/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Foundation
class CalendarHelper {
    static let calendar = Calendar.autoupdatingCurrent

    static func getDaysPadded(for date: Date = Date()) -> [Int] {
        let day = calendar.component(.day, from: date)
//        let firstDayOfThisMonth = calendar.date(byAdding: DateComponents(day: -(day - 1)), to: date)!
        let lastDayOfLastMonth = calendar.date(byAdding: DateComponents(day: -day), to: date)!
        let daysInThisMonth = calendar.range(of: .day, in: .month, for: date)!
        let daysInLastMonth = calendar.component(.weekday, from: lastDayOfLastMonth)
        return Array(repeating: 0, count: daysInLastMonth % 7) + Array(daysInThisMonth)
    }

    static func stringDay(for day: Int) -> String {
        if day != 0 {
            return "\(day)"
        }
        return " "
    }

    static func monthName(for date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        return formatter.string(from: date).capitalized
    }
}
