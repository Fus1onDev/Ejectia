//
//  GeneralView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI
import LaunchAtLogin

struct GeneralView: View {

    var body: some View {
        Form {
            LaunchAtLogin.Toggle {
                Text(L10n.launchAtLogin)
            }
        }
        .padding(20)
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
