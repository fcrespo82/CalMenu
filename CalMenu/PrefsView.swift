//
//  PrefsView.swift
//  CalMenu
//
//  Created by Fernando Crespo on 16/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import SwiftUI

struct PrefsView: View {
    @Binding var text: String

    @State var selectedOption = "Select an option"


    var body: some View {
        Form {
            Section {
                MenuButton(selectedOption) {
                    Button(action: {self.selectedOption = "Option 1"}) {
                        Text("Option 1")
                    }
                    Button(action: {self.selectedOption = "Option 2"}) {
                        Text("Option 2")
                    }
                    Button(action: {self.selectedOption = "Option 3"}) {
                        Text("Option 3")
                    }
                }
                Picker(selection: $selectedOption, label: Text("First day of week")) {
                    Button(action: {self.selectedOption = "Option 1"}) {
                        Text("Option 1")
                    }
                    Text("Monday").tag(2)
                }
                TextField("OK", text: $text)
            }
        }
        .fixedSize()
        .padding()
    }
}

struct PrefsView_Previews: PreviewProvider {
    static var previews: some View {
        PrefsView(text: .constant("Teste"))
    }
}
