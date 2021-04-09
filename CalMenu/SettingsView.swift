//
//  PrefsView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingsView: View {
        
    @State var text: String!

    @State var dismiss: (() -> Void)!

    @State var tabSelected: Toolbar.Tab.Id = .general

    @State var buttons = [
        Toolbar.Button(id: .general, title: "General", imageSystemName: "gearshape.fill"),
        Toolbar.Button(id: .update, title: "Updates", imageSystemName: "arrow.down.circle.fill"),
        Toolbar.Button(id: .donate, title: "Donate", imageSystemName: "dollarsign.square.fill"),
    ]
    @State var s: Int = 0
    var body: some View {
        VStack(spacing: 5) {
            ToolbarView(selectedTab: $tabSelected, buttons: $buttons)
            
            switch tabSelected {
            case .general:
                GeneralTab()
            case .update:
                UpdateTab()
            case .donate:
                DonateTab()
            }

            HStack {
                Spacer()
                Button(action: {
                    if let delegate = NSApp.delegate as? AppDelegate {
                        delegate.closeSettingsWindow(self)
                    }
                }, label: {
                    Text("Close")
                })
            }
            .padding(5)
        }
        .fixedSize()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State(initialValue: .general) var selected: Toolbar.Tab.Id

        var body: some View {
            SettingsView(tabSelected: selected)
                .background(Color(NSColor.windowBackgroundColor))
            SettingsView(tabSelected: selected)
                .background(Color(NSColor.windowBackgroundColor))
                .colorScheme(.dark)
        }
    }
}
