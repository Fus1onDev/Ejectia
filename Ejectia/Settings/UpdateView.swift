//
//  UpdateView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import Defaults

struct UpdateView: View {
    @Default(.automaticallyChecksForUpdates) var automaticallyChecksForUpdates
    @StateObject var updaterViewModel = UpdaterViewModel()
    
    var body: some View {
        Form {
            HStack {
                Toggle(isOn: $automaticallyChecksForUpdates) {
                    Text(L10n.checkForUpdatesAutomatically)
                }
                    .toggleStyle(.checkbox)
                Spacer()
                CheckForUpdatesView(updaterViewModel: updaterViewModel)
            }
        }
        .padding(20)
        .onChange(of: automaticallyChecksForUpdates) { value in
           updaterViewModel.automaticallyCheckForUpdates = value
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
