//
//  TouchBar.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/05.
//

import Cocoa
import SFSafeSymbols

extension AppDelegate {
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
    
    @objc private func touchBarAction() {
        ejectAll()
        // HIDPostMediaKey(NX_KEYTYPE_EJECT)
    }
    
    private func HIDPostMediaKey(_ key: Int32) {
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