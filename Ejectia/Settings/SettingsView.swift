//
//  SettingsView.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/03.
//

import SwiftUI
import SFSafeSymbols

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label(L10n.general, systemSymbol: .sliderHorizontal3)
                }
            MenuBarView()
                .tabItem {
                    Label(L10n.menuBar, systemSymbol: .menubarRectangle)
                }
            TouchBarView()
                .tabItem {
                    if #available(macOS 12.0, *) {
                        Label(L10n.touchBar, systemSymbol: .rectangleAndHandPointUpLeft)
                    } else {
                        Label(L10n.touchBar, systemSymbol: .rectangle)
                    }
                }
            NotificationView()
                .tabItem {
                    Label(L10n.notification, systemSymbol: .bell)
                }
            UpdateView()
                .tabItem {
                    Label(L10n.updates, systemSymbol: .arrowDownCircle)

                }
        }
        .frame(width: 500, height: .none)
    }
    
    private func relaunch() {
        let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
        let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = [path]
        task.launch()
        exit(0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
