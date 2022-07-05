//
//  Defaults.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/29.
//

import Cocoa
import Defaults

extension Defaults.Keys {
    static let isFirstLaunch = Key<Bool>("isFirstLaunch", default: true)
    // Menu Bar
    static let showEjectAllVolumesButton = Key<Bool>("showEjectAllButton", default: true)
    static let showEjectAllVolumesInDiskButtons = Key<Bool>("showEjectAllVolumesInDiskButtons", default: true)
    // Touch Bar
    static let showControlStripButton = Key<Bool>("showControlStripButton", default: true)
    static let displayOnlyWhenExternalVolumeIsConnected = Key<Bool>("displayOnlyWhenExternalVolumeIsConnected", default: true)
    // Updates
    static let automaticallyChecksForUpdates = Key<Bool>("automaticallyChecksForUpdates", default: false)
}
