//
//  WeekView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct WeekHeaderView: View {
    var cellSize: CGFloat = 20
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CalendarHelper.veryShortWeekdaySymbols(), id: \.self) { weekday in
                Text(weekday)
                    .fontWeight(.bold)
                    .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
                    .padding(5)
            }
		}.background(Color(NSColor.controlBackgroundColor).opacity(0.7))
        .cornerRadius(5)
    }
}

struct WeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeekHeaderView()
    }
}
