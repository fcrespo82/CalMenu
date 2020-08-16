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

    var body: some View {
        Form {
            Section {
                MenuButton(label: Text("First day of week")) {
                    Text("Sunday")
                    Text("Monday")
                }
                Picker(selection: .constant(1), label: Text("First day of week")) {
                    Text("Sunday").tag(1)
                    Text("Monday").tag(2)
                }
                TextField("OK", text: $text)
            }
        }.padding()
    }
}

struct PrefsView_Previews: PreviewProvider {
    static var previews: some View {
        PrefsView(text: .constant("Teste"))
    }
}
