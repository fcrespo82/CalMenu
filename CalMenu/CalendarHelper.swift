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

    static func getDaysPadded(for date: Date = Date()) -> [[(Int, Bool, Bool)]] {
        let components = calendar.dateComponents([.year, .month], from: date)

        let firstDayOfThisMonth = calendar.date(from: components)!
        let firstDayOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: firstDayOfThisMonth)!

        let lastDayOfLastMonth = calendar.date(byAdding: DateComponents(day: -1), to: firstDayOfThisMonth)!

        let daysInThisMonth = calendar.range(of: .day, in: .month, for: date)!
        let daysInLastMonth = calendar.range(of: .day, in: .weekOfMonth, for: lastDayOfLastMonth)!
        let daysInNextMonth = calendar.range(of: .day, in: .weekOfMonth, for: firstDayOfNextMonth)!

        let tupleDaysInLastMonth = daysInLastMonth.map { (day) -> (day: Int, dimmed: Bool, selected: Bool) in
            (day: day, dimmed: true, selected: false)
        }
        let tupleDaysInThisMonth = daysInThisMonth.map { (day) -> (day: Int, dimmed: Bool, selected: Bool) in

            let thisDate = calendar.date(byAdding: DateComponents(day: day - 1), to: firstDayOfThisMonth)!
            let select = calendar.compare(thisDate, to: Date(), toGranularity: .day) == .orderedSame

            return (day: day, dimmed: false, selected: select)
        }
        let tupleDaysInNextMonth = daysInNextMonth.map { (day) -> (day: Int, dimmed: Bool, selected: Bool) in
            (day: day, dimmed: true, selected: false)
        }

        var daysOfMonthByWeek: [[(Int, Bool, Bool)]] = []

        // Divide days into weeks easiyly
        _ = (Array(tupleDaysInLastMonth) + Array(tupleDaysInThisMonth) + Array(tupleDaysInNextMonth)).publisher
            .collect(7)
            .collect()
            .sink(receiveValue: { daysOfMonthByWeek = $0 })

        return daysOfMonthByWeek
    }

    static func stringDay(for day: Int) -> String {
        if day != 0 {
            return "\(day)"
        }
        return " "
    }

    static func monthName(for date: Date = Date(), locale: Locale = Locale.autoupdatingCurrent) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        return formatter.string(from: date).capitalized
    }

    static func veryShortWeekdaySymbols(locale: Locale = Locale.autoupdatingCurrent) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        return dateFormatter.veryShortWeekdaySymbols
    }

    static func year(for date: Date = Date(), locale: Locale = Locale.autoupdatingCurrent) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate("YYYY")
        return formatter.string(from: date)
    }
}
