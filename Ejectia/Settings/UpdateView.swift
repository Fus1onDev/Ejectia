//
//  UpdateView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import Defaults

struct UpdateView: View {
    @StateObject var updaterViewModel = UpdaterViewModel()
    
    var body: some View {
        Form {
            HStack {
                Defaults.Toggle(L10n.checkForUpdatesAutomatically, key: .automaticallyChecksForUpdates)
                    .onChange {
                        updaterViewModel.automaticallyCheckForUpdates = $0
                    }
                Spacer()
                CheckForUpdatesView(updaterViewModel: updaterViewModel)
            }
        }
        .padding(20)
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
