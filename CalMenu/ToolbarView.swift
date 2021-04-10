//
//  Test.swift
//  CalMenu
//
//  Created by Fernando Crespo on 07/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct ToolbarView: View {
    @Binding var selectedTab: Toolbar.Tab.Id

    @State var dividerColor: Color = Color(NSColor.controlBackgroundColor)

    @Binding var buttons: [Toolbar.Button]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(buttons) { button in
                Toolbar.ButtonView(buttonInfo: button, selected: $selectedTab)
            }
            Spacer()
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .overlay(Divider().background(dividerColor), alignment: .bottom)
        .animation(.none)
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State(initialValue: .general) var selected: Toolbar.Tab.Id
        @State var buttons: [Toolbar.Button] = [
                Toolbar.Button(id: .general, title: "General", imageSystemName: "gearshape.fill"),
                Toolbar.Button(id: .update, title: "Updates", imageSystemName: "arrow.triangle.2.circlepath.circle.fill"),
                Toolbar.Button(id: .donate, title: "Donate", imageSystemName: "dollarsign.square.fill")
            ]
        var body: some View {
            ToolbarView(selectedTab: $selected, buttons: $buttons)
        }
    }
}
