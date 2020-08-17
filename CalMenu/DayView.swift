//
//  DayView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct DayView: View {
    @State var day: Int
    @State var dimmed: Bool = false
    @State var selected: Bool = false
    var cellSize: CGFloat = 20

    var body: some View {
        var dayTextColor: Color = Color(NSColor.controlTextColor)
        if selected {
            dayTextColor = Color(NSColor.alternateSelectedControlTextColor)
        }
        if dimmed {
            dayTextColor = Color(NSColor.secondaryLabelColor)
        }

        return Text("\(day)")
            .frame(width: self.cellSize, height: self.cellSize, alignment: .center)
            .padding(5)
            .background(self.selected ? Color(NSColor.controlAccentColor) : nil)
            .cornerRadius(.infinity)
            .foregroundColor(dayTextColor)
            .opacity(dimmed ? 0.5 : 1.0)
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                DayView(day: 1)
                DayView(day: 2, selected: true)
                DayView(day: 3, dimmed: true)
            }
            .background(Color(NSColor.windowBackgroundColor))
            .colorScheme(.light)
            VStack {
                DayView(day: 4)
                DayView(day: 5, selected: true)
                DayView(day: 6, dimmed: true)
            }
            .background(Color(NSColor.windowBackgroundColor))
            .colorScheme(.dark)
        }
    }
}
