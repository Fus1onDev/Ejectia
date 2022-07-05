//
//  CheckForUpdatesView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI
import Sparkle

// This additional view is needed for the disabled state on the menu item to work properly before Monterey.
// See https://stackoverflow.com/questions/68553092/menu-not-updating-swiftui-bug for more information
struct CheckForUpdatesView: View {
    @ObservedObject var updaterViewModel: UpdaterViewModel
    
    var body: some View {
        Button(L10n.checkForUpdates, action: updaterViewModel.checkForUpdates)
            .disabled(!updaterViewModel.canCheckForUpdates)
    }
}
