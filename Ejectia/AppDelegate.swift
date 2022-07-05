//
//  AppDelegate.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI
import Defaults
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Stored Properties
    // (because extensions cannot have them)
    
    var statusItem: NSStatusItem!
    
    var volumes: [Volume] = []
    var units: [Int] = []

    let userNotificationCenter = UNUserNotificationCenter.current()
    
    var touchBarItem: NSCustomTouchBarItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.windows.forEach { $0.close() }
        
        // For debug
        // Defaults[.isFirstLaunch] = true
        
        if Defaults[.isFirstLaunch] {
            // Request permissions
            userNotificationCenter.requestAuthorization(options: [.alert, .sound]) { authorized, _ in
                guard authorized else {
                    // print("Not authorized")
                    return
                }
            }
            
            Defaults[.isFirstLaunch] = false
        }
        
        createMenu()
        setObservers()
        reload()
    }
    
    @objc func reload() {
        getVolumes()
        setMenu()
        setupTouchBar(isPresent: !units.isEmpty)
    }
    
    private func setObservers() {
        NSWorkspace.shared.notificationCenter.removeObserver(self)
        
        let notifications: [NSNotification.Name] = [
            NSWorkspace.didMountNotification,
            NSWorkspace.didUnmountNotification
        ]
        
        for notification in notifications {
            NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(reload), name: notification, object: nil)
        }
    }
}
