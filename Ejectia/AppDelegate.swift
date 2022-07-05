//
//  AppDelegate.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/26.
//

import SwiftUI
import Defaults
import SFSafeSymbols
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    
    private var volumes: [Volume] = []
    private var units: [Int] = []
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    private var touchBarItem: NSCustomTouchBarItem?
    
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
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbol: .ejectFill)
        }
        let menu = NSMenu()
        statusItem.menu = menu
        
        getVolumes()
        
        setMenu()
        
        setObservers()
        
        setupTouchBar(isPresent: !units.isEmpty)
    }
    
    @objc func eject(_ sender: NSMenuItem) {
        let volume = volumes[sender.tag]
        ejectAndAlert(volume)
    }
    
    @objc func ejectAll() {
        volumes.forEach({
            ejectAndAlert($0)
        })
    }
    
    @objc func ejectAllInDisk(_ sender: NSMenuItem) {
        let unit = -sender.tag
        
        getVolumesFromUnit(unit).forEach({
            ejectAndAlert($0.element)
        })
    }
    
    func setMenu() {
        
        if let menu = statusItem.menu {
            menu.removeAllItems()
            
            if units.isEmpty {
                menu.addItem(NSMenuItem(
                    title: L10n.noExternalVolumeConnected,
                    action: nil,
                    keyEquivalent: ""
                ))
            } else {
                if Defaults[.showEjectAllVolumesButton] && units.count > 1 {
                    menu.addItem(NSMenuItem(
                        title: L10n.ejectAllVolumes,
                        action: #selector(AppDelegate.ejectAll),
                        keyEquivalent: ""
                    ))
                }
                
                for unit in units {
                    let header = NSMenuItem()
                    header.title = L10n.diskNum(unit)
                    menu.addItem(header)
                    
                    let unitVolumes = getVolumesFromUnit(unit)
                    
                    if Defaults[.showEjectAllVolumesInDiskButtons] && unitVolumes.count > 1 {
                        let ejectAllInDisk = NSMenuItem()
                        ejectAllInDisk.title = L10n.ejectNumVolumes(unitVolumes.count)
                        ejectAllInDisk.tag = -unit
                        ejectAllInDisk.action = #selector(AppDelegate.ejectAllInDisk(_:))
                        menu.addItem(ejectAllInDisk)
                    }
                    
                    for (index, volume) in unitVolumes {
                        let item = NSMenuItem()
                        item.title = volume.name
                        item.image = volume.icon
                        item.image?.size = NSSize(width: 18, height: 18)
                        item.tag = index
                        item.action = #selector(AppDelegate.eject(_:))
                        menu.addItem(item)
                    }
                }
            }
            
            menu.addItem(NSMenuItem.separator())
            
            menu.addItem(NSMenuItem(
                title: L10n.preferences,
                action: #selector(openPreferencesWindow),
                keyEquivalent: ""
            ))
            
            menu.addItem(NSMenuItem(
                title: L10n.aboutEjectia,
                action: #selector(showAbout),
                keyEquivalent: ""
            ))
            
            menu.addItem(NSMenuItem(
                title: L10n.quitEjectia,
                action: #selector(NSApplication.terminate(_:)),
                keyEquivalent: "q"
            ))
        }
    }
    
    @objc func reloadMenu() {
        getVolumes()
        setMenu()
        
        setupTouchBar(isPresent: !units.isEmpty)
    }
    
    @objc func openPreferencesWindow() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        NSApp.windows.forEach {
            if $0.canBecomeMain {
                $0.orderFrontRegardless()
            }
        }
    }
    
    @objc func showAbout() {
        NSApp.activate(ignoringOtherApps: true)
        NSApp.orderFrontStandardAboutPanel()
    }
    
    func setObservers() {
        NSWorkspace.shared.notificationCenter.removeObserver(self)
        
        let notifications: [NSNotification.Name] = [
            NSWorkspace.didMountNotification,
            NSWorkspace.didUnmountNotification
        ]
        
        for notification in notifications {
            NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(reloadMenu), name: notification, object: nil)
        }
    }
    
    func getVolumes() {
        if let mountedVolumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) {
            volumes = mountedVolumeURLs.filter({isVolumeURL($0)}).compactMap({Volume(url: $0)})
            units = unique(volumes.map({$0.unit}))
        }
    }
    
    func getVolumesFromUnit(_ unit: Int) -> [EnumeratedSequence<[Volume]>.Element] {
        return volumes.enumerated().filter({$0.element.unit == unit})
    }
    
    func ejectAndAlert(_ volume: Volume) {
        volume.eject(force: false, action: {
            self.alert(
                title: L10n.volWasSuccessfullyEjected(volume.name),
                body: L10n.safelyRemoved,
                sound: .default,
                identifier: volume.id
            )
        }, errorAction: { description in
            self.alert(
                title: L10n.failedToEjectVol(volume.name),
                body: description,
                sound: .defaultCritical,
                identifier: volume.id
            )
        })
    }
    
    func alert(title: String, body: String, sound: UNNotificationSound, identifier: String) {
        userNotificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = sound
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            self.userNotificationCenter.add(request)
        }
    }
    
    private func isVolumeURL(_ url: URL) -> Bool {
        url.pathComponents.count > 1 && url.pathComponents[1] == "Volumes"
    }
    
    private func unique(_ array: [Int]) -> [Int] {
        return Array(Set(array))
    }
    
    func setupTouchBar(isPresent: Bool) {
        DFRSystemModalShowsCloseBoxWhenFrontMost(isPresent)
        
        let touchBarIdentifier = NSTouchBarItem.Identifier(rawValue: "dev.fus1on.ejectia.touchbar")
        if touchBarItem == nil {
            touchBarItem = NSCustomTouchBarItem(identifier: touchBarIdentifier)
        }
        let iconImage = NSImage(systemSymbol: .ejectFill)!.resize(width: 18, height: 18)
        iconImage.isTemplate = true
        touchBarItem?.view = NSButton(image: iconImage, target: self, action: #selector(touchBarAction))
        if isPresent {
            NSTouchBarItem.addSystemTrayItem(touchBarItem)
        } else {
            NSTouchBarItem.removeSystemTrayItem(touchBarItem)
        }
        DFRElementSetControlStripPresenceForIdentifier(touchBarIdentifier, isPresent)
    }
    
    @objc func touchBarAction() {
        ejectAll()
        // HIDPostMediaKey(NX_KEYTYPE_EJECT)
    }
    
    func HIDPostMediaKey(_ key: Int32) {
        func doMediaKey(_ key: Int, down: Bool) {
            let modifierFlags = NSEvent.ModifierFlags(rawValue: down ? 0xA00 : 0xB00)
            let nsEvent = NSEvent.otherEvent(with: .systemDefined, location: NSPoint(x: 0, y: 0), modifierFlags: modifierFlags, timestamp: 0, windowNumber: 0, context: nil, subtype: 8, data1: (key << 16) | ((down ? 0xA : 0xB) << 8), data2: -1)
            let cgEvent = nsEvent?.cgEvent
            cgEvent?.post(tap: .cghidEventTap)
        }
        doMediaKey(Int(key), down: true)
        doMediaKey(Int(key), down: false)
    }
}
