//
//  DayView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct DayView: View {
    var dayInfo: DayInfo
    var cellSize: CGFloat = 20
    @State var dayTextColor: Color = Color(NSColor.controlTextColor)

    var body: some View {
        return Text("\(dayInfo.day)")
            .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
            .padding(5)
            .background(dayInfo.selected ? Color(NSColor.controlAccentColor) : nil)
            .cornerRadius(self.cellSize)
            .foregroundColor(dayInfo.selected ? Color(NSColor.alternateSelectedControlTextColor) : dayInfo.dimmed ? Color(NSColor.secondaryLabelColor) : Color(NSColor.textColor)
            )
            .opacity(dayInfo.dimmed ? 0.5 : 1.0)
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                DayView(dayInfo: DayInfo(day: 1))
                DayView(dayInfo: DayInfo(day: 2, selected: true))
                DayView(dayInfo: DayInfo(day: 3, dimmed: true))
            }
            .background(Color(NSColor.windowBackgroundColor))
            .colorScheme(.light)
            HStack {
                DayView(dayInfo: DayInfo(day: 1))
                DayView(dayInfo: DayInfo(day: 2, selected: true))
                DayView(dayInfo: DayInfo(day: 3, dimmed: true))
            }
            .background(Color(NSColor.windowBackgroundColor))
            .colorScheme(.dark)
        }
    }
}
