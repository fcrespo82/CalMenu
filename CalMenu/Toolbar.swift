//
//  Toolbar.swift
//  CalMenu
//
//  Created by Fernando Crespo on 08/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import Foundation
import SwiftUI

public struct Toolbar {
    public struct Tab {
        public enum Id {
            case general
            case update
            case donate
        }
    }

    public struct Button: Identifiable {
        public var id: Toolbar.Tab.Id
        public var title: LocalizedStringKey
        public var imageSystemName: String?
    }

    public struct ButtonView: View {
        @State var buttonInfo: Toolbar.Button

        @Binding var selected: Toolbar.Tab.Id

        @State var toolbarSelectedTextColor: Color = .white
        @State var toolbarUnselectedTextColor: Color = .secondary

        @State var toolbarSelectedButtonColor: Color = .accentColor
        @State var toolbarUnselectedTButtonColor: Color = .clear

        @State var toolbarButtonCornerRadius: CGFloat = 5

        public var body: some View {
            let isSelected = selected == buttonInfo.id
            SwiftUI.Button(action: {
                selected = buttonInfo.id
            }, label: {
                VStack {
                    if #available(OSX 11.0, *), let imageSystemName = buttonInfo.imageSystemName {
                        Image(systemName: imageSystemName).imageScale(.large)
                    }
                    Text(buttonInfo.title)
                }
                .padding([.leading, .trailing], 5)
                .frame(minWidth: 50, idealHeight: 50)
            })
                .foregroundColor(isSelected ? toolbarSelectedTextColor : toolbarUnselectedTextColor)
                .background(isSelected ? toolbarSelectedButtonColor : toolbarUnselectedTButtonColor)
                .cornerRadius(toolbarButtonCornerRadius)
                .buttonStyle(BorderlessButtonStyle())
        }
    }
}
