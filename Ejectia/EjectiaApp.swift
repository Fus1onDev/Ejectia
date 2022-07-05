//
//  EjectiaApp.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI

@main
struct EjectiaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
        }
        Settings {
            SettingsView()
        }
    }
}
