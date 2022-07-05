//
//  TouchBarView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import Defaults

struct TouchBarView: View {
    @Default(.showControlStripButton) var showControlStripButton
    @Default(.displayOnlyWhenExternalVolumeIsConnected) var displayOnlyWhenExternalVolumeIsConnected
    
    var body: some View {
        Form {
            Toggle(isOn: $showControlStripButton) {
                Text(L10n.showControlStripButton)
            }
                .toggleStyle(.checkbox)
            Toggle(isOn: $displayOnlyWhenExternalVolumeIsConnected) {
                Text(L10n.displayOnlyWhenExternalVolumeIsConnected)
            }
                .toggleStyle(.checkbox)
        }
        .padding(20)
    }
}

struct TouchBarView_Previews: PreviewProvider {
    static var previews: some View {
        TouchBarView()
    }
}
