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
    var calendar = Calendar.autoupdatingCurrent
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(calendar.veryShortWeekdaySymbols, id: \.self) { weekday in
                Text(weekday)
                    .fontWeight(.bold)
                    .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
                    .padding(5)
            }
        }.background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(5)
    }
}

struct WeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeekHeaderView()
    }
}
