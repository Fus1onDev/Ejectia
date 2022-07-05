//
//  MenuBarView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import Defaults

struct MenuBarView: View {
    @Default(.showEjectAllVolumesButton) var showEjectAllVolumesButton
    @Default(.showEjectAllVolumesInDiskButtons) var showEjectAllVolumesInDiskButtons
    
    var body: some View {
        Form {
            Toggle(isOn: $showEjectAllVolumesButton) {
                Text(L10n.showEjectAllVolumesButton)
            }
                .toggleStyle(.checkbox)
            Toggle(isOn: $showEjectAllVolumesInDiskButtons) {
                Text(L10n.showEjectAllVolumesInDiskButtons)
            }
                .toggleStyle(.checkbox)
        }
        .padding(20)
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
