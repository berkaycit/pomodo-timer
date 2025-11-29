//
//  MenuBarPopoverView.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import SwiftUI

// MARK: - Main Popover View

/// Main popover view displayed when clicking the menu bar item.
/// Contains timer display, preset selection, and control buttons.
struct MenuBarPopoverView: View {
    @EnvironmentObject var timerManager: TimerManager
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 16) {
            // Timer Display
            TimerDisplaySection()

            Divider()

            // Preset Selection
            PresetSelectionSection()

            Divider()

            // Controls
            ControlButtonsSection()

            Divider()

            // Quit Button
            QuitButton()
        }
        .padding(16)
        .frame(width: 280)
    }
}

// MARK: - Timer Display Section

struct TimerDisplaySection: View {
    @EnvironmentObject var timerManager: TimerManager

    var body: some View {
        VStack(spacing: 4) {
            Text(displayText)
                .font(.system(size: 32, weight: .semibold, design: .monospaced))
                .foregroundColor(displayColor)

            Text(stateText)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)
        }
    }

    private var displayText: String {
        if timerManager.state == .finished {
            return "00:00"
        } else {
            return timerManager.formattedTime
        }
    }

    private var displayColor: Color {
        switch timerManager.state {
        case .finished:
            return .green
        case .running:
            return .primary
        case .paused:
            return .orange
        case .idle:
            return .secondary
        }
    }

    private var stateText: String {
        switch timerManager.state {
        case .idle:
            return "Ready"
        case .running:
            return "Running"
        case .paused:
            return "Paused"
        case .finished:
            return "Done!"
        }
    }
}

// MARK: - Preset Selection Section

struct PresetSelectionSection: View {
    @EnvironmentObject var timerManager: TimerManager

    var body: some View {
        VStack(spacing: 8) {
            Text("Duration")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)

            HStack(spacing: 8) {
                ForEach(TimerPreset.allCases, id: \.rawValue) { preset in
                    PresetSelectionButton(preset: preset)
                }
            }
        }
    }
}

struct PresetSelectionButton: View {
    @EnvironmentObject var timerManager: TimerManager
    let preset: TimerPreset

    var body: some View {
        Button(action: {
            timerManager.selectPreset(preset)
        }) {
            VStack(spacing: 4) {
                Text("\(preset.minutes)")
                    .font(.system(size: 20, weight: .semibold))
                Text("min")
                    .font(.system(size: 9, weight: .regular))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.accentColor : Color.secondary.opacity(0.1))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .disabled(timerManager.state == .running)
    }

    private var isSelected: Bool {
        timerManager.selectedPreset == preset
    }
}

// MARK: - Control Buttons Section

struct ControlButtonsSection: View {
    @EnvironmentObject var timerManager: TimerManager

    var body: some View {
        HStack(spacing: 8) {
            if timerManager.state == .finished {
                // Restart button
                Button(action: {
                    timerManager.start()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Restart")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            } else {
                // Play/Pause button
                Button(action: handlePlayPause) {
                    HStack {
                        Image(systemName: playPauseIcon)
                        Text(playPauseText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)

                // Reset button (if not idle)
                if timerManager.state != .idle {
                    Button(action: {
                        timerManager.reset()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var playPauseIcon: String {
        switch timerManager.state {
        case .idle, .finished:
            return "play.fill"
        case .running:
            return "pause.fill"
        case .paused:
            return "play.fill"
        }
    }

    private var playPauseText: String {
        switch timerManager.state {
        case .idle:
            return "Start"
        case .running:
            return "Pause"
        case .paused:
            return "Resume"
        case .finished:
            return "Start"
        }
    }

    private func handlePlayPause() {
        switch timerManager.state {
        case .idle, .finished:
            timerManager.start()
        case .running:
            timerManager.pause()
        case .paused:
            timerManager.resume()
        }
    }
}

// MARK: - Quit Button

struct QuitButton: View {
    var body: some View {
        Button(action: {
            NSApplication.shared.terminate(nil)
        }) {
            HStack {
                Image(systemName: "power")
                    .font(.system(size: 11))
                Text("Quit")
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    MenuBarPopoverView()
        .environmentObject(TimerManager())
}
