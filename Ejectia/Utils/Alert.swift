//
//  Alert.swift
//  Ejectia
//
//  Created by Fus1onDev on 2022/07/05.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func alert(title: String, body: String, sound: UNNotificationSound, identifier: String) {
        self.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = sound
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            self.add(request)
        }
    }
}
