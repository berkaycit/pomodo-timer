//
//  TimerManager.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import Foundation
import Combine
import OSLog

// MARK: - Timer State

enum TimerState {
    case idle
    case running
    case paused
    case finished
}

// MARK: - Timer Preset

enum TimerPreset: Int, CaseIterable, Hashable {
    case one = 1
    case twentyFive = 25
    case fortyFive = 45

    var seconds: TimeInterval {
        TimeInterval(self.rawValue * 60)
    }

    var displayName: String {
        "\(self.rawValue)"
    }

    var minutes: Int {
        self.rawValue
    }
}

// MARK: - Timer Manager

/// Manages the Pomodoro timer state, countdown logic, and preset selection.
/// Uses Combine publishers to notify observers of state changes.
/// All state updates are performed on the main thread for thread safety.
final class TimerManager: ObservableObject {
    // MARK: Published Properties

    /// Current state of the timer (idle, running, paused, finished)
    @Published private(set) var state: TimerState = .idle

    /// Remaining time in seconds
    @Published private(set) var remainingTime: TimeInterval = TimerPreset.twentyFive.seconds

    /// Currently selected preset duration
    @Published private(set) var selectedPreset: TimerPreset = .twentyFive

    // MARK: Private Properties

    private var timer: Timer?
    private var endTime: Date?
    private let notificationService: NotificationServiceProtocol
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "pomodo-timer",
                               category: "TimerManager")

    // MARK: - Initialization

    init(notificationService: NotificationServiceProtocol = NotificationService()) {
        self.notificationService = notificationService
        loadPreset()
        remainingTime = selectedPreset.seconds
    }

    deinit {
        stopTimer()
    }

    // MARK: - Public Methods

    /// Starts the timer from idle or finished state
    func start() {
        ensureMainThread {
            guard self.state == .idle || self.state == .finished else {
                self.logger.warning("Attempted to start timer in invalid state: \(String(describing: self.state))")
                return
            }

            // If timer is finished, reset remainingTime to selected preset
            if self.state == .finished {
                self.remainingTime = self.selectedPreset.seconds
            }

            self.state = .running
            self.endTime = Date().addingTimeInterval(self.remainingTime)
            self.startTimer()
        }
    }

    /// Pauses the running timer
    func pause() {
        ensureMainThread {
            guard self.state == .running else {
                self.logger.warning("Attempted to pause timer in invalid state: \(String(describing: self.state))")
                return
            }

            self.state = .paused
            self.stopTimer()
        }
    }

    /// Resumes the paused timer from where it left off
    func resume() {
        ensureMainThread {
            guard self.state == .paused else {
                self.logger.warning("Attempted to resume timer in invalid state: \(String(describing: self.state))")
                return
            }

            self.state = .running
            self.endTime = Date().addingTimeInterval(self.remainingTime)
            self.startTimer()
        }
    }

    /// Resets the timer to the selected preset duration
    func reset() {
        ensureMainThread {
            self.stopTimer()
            self.state = .idle
            self.remainingTime = self.selectedPreset.seconds
        }
    }

    /// Changes the selected preset and updates remaining time
    /// - Parameter preset: The new preset duration to use
    /// - Note: Cannot change preset while timer is running
    func selectPreset(_ preset: TimerPreset) {
        ensureMainThread {
            guard self.state != .running else {
                self.logger.warning("Cannot change preset while timer is running")
                return
            }

            // If changing preset while paused, reset to idle state
            if self.state == .paused {
                self.stopTimer()
                self.state = .idle
            }

            // Update remainingTime FIRST, then selectedPreset
            // This ensures CombineLatest fires with correct values
            self.remainingTime = preset.seconds
            self.selectedPreset = preset
            self.savePreset()
        }
    }

    // MARK: - Private Methods

    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: Constants.Timer.tickInterval,
            repeats: true
        ) { [weak self] _ in
            self?.tick()
        }
        timer?.tolerance = Constants.Timer.tolerance
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        endTime = nil
    }

    private func tick() {
        guard let endTime = endTime else {
            stopTimer()
            return
        }

        let remaining = endTime.timeIntervalSinceNow

        ensureMainThread {
            if remaining <= 0 {
                self.remainingTime = 0
                self.state = .finished
                self.stopTimer()
                self.handleTimerCompletion()
            } else {
                // Round up to prevent skipping seconds due to timer drift
                self.remainingTime = ceil(remaining)
            }
        }
    }

    private func handleTimerCompletion() {
        notificationService.sendTimerCompletedNotification()
    }

    /// Ensures the closure is executed on the main thread
    /// - Parameter work: The closure to execute
    private func ensureMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async {
                work()
            }
        }
    }

    // MARK: - UserDefaults Persistence

    private func savePreset() {
        UserDefaults.standard.set(selectedPreset.rawValue, forKey: Constants.UserDefaultsKeys.selectedPreset)
    }

    private func loadPreset() {
        let savedValue = UserDefaults.standard.integer(forKey: Constants.UserDefaultsKeys.selectedPreset)
        if let preset = TimerPreset(rawValue: savedValue) {
            selectedPreset = preset
        } else {
            selectedPreset = .twentyFive
        }
    }

    // MARK: - Formatting

    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
