//
//  TimerManager.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import Foundation
import Combine

// MARK: - Timer State

enum TimerState {
    case idle
    case running
    case paused
    case finished
}

// MARK: - Timer Preset

enum TimerPreset: Int, CaseIterable, Hashable {
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
class TimerManager: ObservableObject {
    // MARK: Published Properties

    /// Current state of the timer (idle, running, paused, finished)
    @Published var state: TimerState = .idle

    /// Remaining time in seconds
    @Published var remainingTime: TimeInterval = TimerPreset.twentyFive.seconds

    /// Currently selected preset duration
    @Published var selectedPreset: TimerPreset = .twentyFive

    // MARK: Private Properties

    private var timer: Timer?
    private var endTime: Date?
    private let userDefaultsKey = "selectedPreset"

    // MARK: - Initialization

    init() {
        loadPreset()
        remainingTime = selectedPreset.seconds
    }

    deinit {
        stopTimer()
    }

    // MARK: - Public Methods

    /// Starts the timer from idle or finished state
    func start() {
        guard state == .idle || state == .finished else { return }

        state = .running
        endTime = Date().addingTimeInterval(remainingTime)
        startTimer()
    }

    /// Pauses the running timer
    func pause() {
        guard state == .running else { return }

        state = .paused
        stopTimer()
    }

    /// Resumes the paused timer from where it left off
    func resume() {
        guard state == .paused else { return }

        state = .running
        endTime = Date().addingTimeInterval(remainingTime)
        startTimer()
    }

    /// Resets the timer to the selected preset duration
    func reset() {
        stopTimer()
        state = .idle
        remainingTime = selectedPreset.seconds
    }

    /// Changes the selected preset and updates remaining time
    /// - Parameter preset: The new preset duration to use
    /// - Note: Cannot change preset while timer is running
    func selectPreset(_ preset: TimerPreset) {
        guard state != .running else { return }

        // Update remainingTime FIRST, then selectedPreset
        // This ensures CombineLatest fires with correct values
        remainingTime = preset.seconds
        selectedPreset = preset
        savePreset()
    }

    // MARK: - Private Methods

    private func startTimer() {
        // Use Timer with tolerance for better performance
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        timer?.tolerance = 0.1 // 100ms tolerance for power efficiency
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

        if remaining <= 0 {
            remainingTime = 0
            state = .finished
            stopTimer()
        } else {
            remainingTime = remaining
        }
    }

    // MARK: - UserDefaults Persistence

    private func savePreset() {
        UserDefaults.standard.set(selectedPreset.rawValue, forKey: userDefaultsKey)
    }

    private func loadPreset() {
        let savedValue = UserDefaults.standard.integer(forKey: userDefaultsKey)
        if let preset = TimerPreset(rawValue: savedValue) {
            selectedPreset = preset
        } else {
            // Default to 25 minutes if no valid preset found
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
