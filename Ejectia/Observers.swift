//
//  Observers.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/06.
//

import Foundation
import Defaults

extension AppDelegate {
    func setVolumeObservers() {
        NSWorkspace.shared.notificationCenter.removeObserver(self)
        
        let notifications: [NSNotification.Name] = [
            NSWorkspace.didMountNotification,
            NSWorkspace.didUnmountNotification
        ]
        
        for notification in notifications {
            NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(reload), name: notification, object: nil)
        }
    }
    
    func setMenuBarObservers() {
        _ = Defaults.observe(keys: .showEjectAllVolumesButton, .showEjectAllVolumesInDiskButtons) {
            self.setMenu()
        }.tieToLifetime(of: self)
    }
    
    func setTouchBarObservers() {
        _ = Defaults.observe(keys: .showControlStripButton, .displayOnlyWhenExternalVolumeIsConnected) {
            self.setupTouchBar()
        }.tieToLifetime(of: self)
    }
}
