//
//  AppDelegate.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import SwiftUI
import AppKit
import Combine
import UserNotifications
import OSLog

/// Main application delegate that manages the menu bar interface.
/// Coordinates between the timer manager and the menu bar UI.
final class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    // MARK: Properties

    var statusItem: NSStatusItem!
    var popover: NSPopover!
    var timerManager: TimerManager!
    private var notificationService: NotificationServiceProtocol!
    private var cancellables = Set<AnyCancellable>()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "pomodo-timer",
                               category: "AppDelegate")

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set notification delegate
        UNUserNotificationCenter.current().delegate = self

        // Initialize notification service
        notificationService = NotificationService()

        // Request notification permission
        notificationService.requestAuthorization { [weak self] granted, error in
            if let error = error {
                self?.logger.error("Notification permission denied: \(error.localizedDescription)")
            }
        }

        // Initialize timer manager
        timerManager = TimerManager(notificationService: notificationService)

        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.title = timerManager.formattedTime
            button.action = #selector(togglePopover)
            button.target = self
        }

        // Create popover
        popover = NSPopover()
        popover.contentSize = NSSize(width: Constants.UI.popoverWidth,
                                    height: Constants.UI.popoverHeight)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(
            rootView: MenuBarPopoverView()
                .environmentObject(timerManager)
        )

        // Observe timer changes to update menu bar
        // Use combineLatest with debounce to avoid race conditions
        Publishers.CombineLatest3(
            timerManager.$remainingTime,
            timerManager.$state,
            timerManager.$selectedPreset
        )
        .debounce(for: .milliseconds(10), scheduler: DispatchQueue.main)
        .sink { [weak self] _, _, _ in
            self?.updateMenuBarTitle()
        }
        .store(in: &cancellables)

        // Hide dock icon for minimal footprint
        NSApp.setActivationPolicy(.accessory)
    }

    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

    private func updateMenuBarTitle() {
        guard let button = statusItem.button else { return }

        let title: String
        switch timerManager.state {
        case .finished:
            title = "✓ Done"
        case .running:
            title = "⏱ \(timerManager.formattedTime)"
        case .paused:
            title = "⏸ \(timerManager.formattedTime)"
        case .idle:
            title = "\(timerManager.formattedTime)"
        }

        button.title = title
    }

    // MARK: - UNUserNotificationCenterDelegate

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show notification even when app is in foreground
        completionHandler([.banner, .sound])
    }
}
