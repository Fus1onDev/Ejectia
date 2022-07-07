//
//  TouchBarView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import Defaults

struct TouchBarView: View {
    var body: some View {
        Form {
            Defaults.Toggle(L10n.showControlStripButton, key: .showControlStripButton)
            Defaults.Toggle(L10n.displayOnlyWhenExternalVolumeIsConnected, key: .displayOnlyWhenExternalVolumeIsConnected)
        }
        .padding(20)
    }
}

struct TouchBarView_Previews: PreviewProvider {
    static var previews: some View {
        TouchBarView()
    }
}
