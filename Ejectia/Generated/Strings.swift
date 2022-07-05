// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// About Ejectia
  internal static let aboutEjectia = L10n.tr("Localizable", "about_ejectia")
  /// Check for Updates...
  internal static let checkForUpdates = L10n.tr("Localizable", "check_for_updates")
  /// Check for updates automatically
  internal static let checkForUpdatesAutomatically = L10n.tr("Localizable", "check_for_updates_automatically")
  /// Disk %d
  internal static func diskNum(_ p1: Int) -> String {
    return L10n.tr("Localizable", "disk_num", p1)
  }
  /// Display only when external volume is connected
  internal static let displayOnlyWhenExternalVolumeIsConnected = L10n.tr("Localizable", "display_only_when_external_volumeIs_connected")
  /// Eject All Volumes
  internal static let ejectAllVolumes = L10n.tr("Localizable", "eject_all_volumes")
  /// Eject %d Volumes
  internal static func ejectNumVolumes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "eject_num_volumes", p1)
  }
  /// Failed to eject "%@"
  internal static func failedToEjectVol(_ p1: Any) -> String {
    return L10n.tr("Localizable", "failed_to_eject_vol", String(describing: p1))
  }
  /// General
  internal static let general = L10n.tr("Localizable", "general")
  /// Launch at Login
  internal static let launchAtLogin = L10n.tr("Localizable", "launch_at_login")
  /// Menu Bar
  internal static let menuBar = L10n.tr("Localizable", "menu_bar")
  /// No external volume connected
  internal static let noExternalVolumeConnected = L10n.tr("Localizable", "no_external_volume_connected")
  /// Notification
  internal static let notification = L10n.tr("Localizable", "notification")
  /// Preferences...
  internal static let preferences = L10n.tr("Localizable", "preferences")
  /// Quit Ejectia
  internal static let quitEjectia = L10n.tr("Localizable", "quit_ejectia")
  /// The device can now be safely removed.
  internal static let safelyRemoved = L10n.tr("Localizable", "safely_removed")
  /// Show Eject Button on Control Strip
  internal static let showControlStripButton = L10n.tr("Localizable", "show_control_strip_button")
  /// Show "Eject All Volumes" Button
  internal static let showEjectAllVolumesButton = L10n.tr("Localizable", "show_eject_all_volumes_button")
  /// Show "Eject All Volumes in Disk" Buttons
  internal static let showEjectAllVolumesInDiskButtons = L10n.tr("Localizable", "show_eject_all_volumes_in_disk_buttons")
  /// Touch Bar
  internal static let touchBar = L10n.tr("Localizable", "touch_bar")
  /// Updates
  internal static let updates = L10n.tr("Localizable", "updates")
  /// "%@" was successfully ejected
  internal static func volWasSuccessfullyEjected(_ p1: Any) -> String {
    return L10n.tr("Localizable", "vol_was_successfully_ejected", String(describing: p1))
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
