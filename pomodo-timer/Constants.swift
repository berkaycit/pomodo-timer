//
//  Constants.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import Foundation

// MARK: - App Constants

/// Centralized constants for the application
enum Constants {

    // MARK: - Timer

    enum Timer {
        /// Tolerance for timer firing (in seconds) for power efficiency
        static let tolerance: TimeInterval = 0.1

        /// Timer tick interval (in seconds)
        static let tickInterval: TimeInterval = 1.0
    }

    // MARK: - UserDefaults Keys

    enum UserDefaultsKeys {
        /// Key for storing selected preset
        static let selectedPreset = "selectedPreset"
    }

    // MARK: - UI

    enum UI {
        /// Popover width
        static let popoverWidth: CGFloat = 280

        /// Popover height
        static let popoverHeight: CGFloat = 140

        /// Standard padding
        static let standardPadding: CGFloat = 16

        /// Standard spacing
        static let standardSpacing: CGFloat = 16
    }
}
