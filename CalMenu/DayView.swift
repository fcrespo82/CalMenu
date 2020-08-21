//
//  DayView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct DayView: View {
    @Binding var day: Int
    @Binding var dimmed: Bool
    @Binding var selected: Bool
    var cellSize: CGFloat = 20
    @State var dayTextColor: Color = Color(NSColor.controlTextColor)

    var body: some View {
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
                DayView(day: .constant(1), dimmed: .constant(false), selected: .constant(false))
                DayView(day: .constant(2), dimmed: .constant(false), selected: .constant(true))
                DayView(day: .constant(3), dimmed: .constant(true), selected: .constant(false))
            }
            .background(Color(NSColor.windowBackgroundColor))
            .colorScheme(.light)
//            VStack {
//                DayView(day: 4)
//                DayView(day: 5, selected: true)
//                DayView(day: 6, dimmed: true)
//            }
//            .background(Color(NSColor.windowBackgroundColor))
//            .colorScheme(.dark)
        }
    }
}
