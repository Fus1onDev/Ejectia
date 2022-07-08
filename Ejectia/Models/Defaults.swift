//
//  Defaults.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/06/29.
//

import Cocoa
import Defaults

enum ControlStripButtonAction: String, CaseIterable, Defaults.Serializable {
    case ejectAll = "Eject All"
    case actAsMediaEjectKey = "Act as Media Eject Key"
    
    var localized: String {
        switch self {
        case .ejectAll:
            return L10n.ejectAllVolumes
        case .actAsMediaEjectKey:
            return L10n.actAsMediaEjectKey
        }
    }
}

extension Defaults.Keys {
    static let isFirstLaunch = Key<Bool>("isFirstLaunch", default: true)
    // Menu Bar
    static let showEjectAllVolumesButton = Key<Bool>("showEjectAllButton", default: true)
    static let showEjectAllVolumesInDiskButtons = Key<Bool>("showEjectAllVolumesInDiskButtons", default: true)
    // Touch Bar
    static let showControlStripButton = Key<Bool>("showControlStripButton", default: true)
    static let displayOnlyWhenExternalVolumeIsConnected = Key<Bool>("displayOnlyWhenExternalVolumeIsConnected", default: true)
    static let controlStripButtonAction = Key<ControlStripButtonAction>("controlStripButtonAction", default: .ejectAll)
    // Notifications
    static let enableNotifications = Key<Bool>("enableNotifications", default: true)
    // Updates
    static let automaticallyChecksForUpdates = Key<Bool>("automaticallyChecksForUpdates", default: false)
}
