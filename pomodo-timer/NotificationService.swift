//
//  NotificationService.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import Foundation
import UserNotifications
import OSLog

// MARK: - Notification Service Protocol

/// Protocol defining notification service capabilities
protocol NotificationServiceProtocol {
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void)
    func sendTimerCompletedNotification()
}

// MARK: - Notification Service

/// Service responsible for handling all notification-related operations.
/// Separates notification concerns from timer logic following Single Responsibility Principle.
final class NotificationService: NotificationServiceProtocol {

    // MARK: - Properties

    private let notificationCenter: UNUserNotificationCenter
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "pomodo-timer",
                                category: "NotificationService")

    // MARK: - Initialization

    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }

    // MARK: - Public Methods

    /// Requests authorization for notifications
    /// - Parameter completion: Called with authorization result
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { [weak self] granted, error in
            if let error = error {
                self?.logger.error("Notification authorization failed: \(error.localizedDescription)")
            }
            completion(granted, error)
        }
    }

    /// Sends a notification when the Pomodoro timer completes
    func sendTimerCompletedNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Timer"
        content.body = "Pomodoro time is up!"
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        notificationCenter.add(request) { [weak self] error in
            if let error = error {
                self?.logger.error("Failed to send notification: \(error.localizedDescription)")
            }
        }
    }
}
