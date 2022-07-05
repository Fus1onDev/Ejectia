//
//  UpdaterViewModel.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI
import Sparkle

// This view model class manages Sparkle's updater and publishes when new updates are allowed to be checked
final class UpdaterViewModel: ObservableObject {
    private let updaterController: SPUStandardUpdaterController
    
    @Published var canCheckForUpdates = false
    
    var automaticallyCheckForUpdates: Bool {
        get {
            return updaterController.updater.automaticallyChecksForUpdates
        }
        set(newValue) {
            updaterController.updater.automaticallyChecksForUpdates = newValue
        }
    }
    
    init() {
        // If you want to start the updater manually, pass false to startingUpdater and call .startUpdater() later
        // This is where you can also pass an updater delegate if you need one
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        
        updaterController.updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
        
        if automaticallyCheckForUpdates {
            updaterController.updater.checkForUpdatesInBackground()
        }
    }
    
    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }
}
