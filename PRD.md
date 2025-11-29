# Product Requirements Document (PRD)
# Pomodo Timer

**Version:** 1.0
**Date:** November 29, 2025
**Platform:** macOS
**Status:** Implemented

---

## 1. Executive Summary

Pomodo Timer is a performance-focused Pomodoro timer application designed specifically for macOS. Living in the menu bar, the app facilitates time management throughout the day while imposing virtually no load on system resources.

**Core Value Proposition:**
- Always visible in menu bar, minimal design
- Ultra-lightweight: no CPU/RAM burden even during extended use
- Simple, focused user experience
- Native macOS notifications when timer completes

---

## 2. Features

### Core Features
- **Menu Bar Integration:** Lives in the menu bar, always accessible
- **Quick Presets:** 1, 25, and 45 minute duration options (1 min for testing)
- **Timer Controls:** Start, Pause, Resume, Reset
- **Native Notifications:** macOS notification with sound when timer completes
- **State Indication:** Clear visual feedback for timer state (Ready, Running, Paused, Done)
- **Auto Theme:** Automatically adapts to macOS Dark/Light mode
- **Persistent Preferences:** Remembers last selected preset

### Technical Features
- Ultra-lightweight: CPU <0.5%, RAM ~30-40 MB
- Thread-safe implementation
- Protocol-based architecture
- Structured logging with OSLog
- Separation of concerns (NotificationService, TimerManager, etc.)

---

## 3. User Stories

### US-001: Quick Start
**As a user**, I want to start a 25-minute timer with one click, **so that** I can quickly begin a focus session.

**Acceptance Criteria:**
- Default duration is 25 minutes
- Single click on Play button starts countdown
- Timer state updates in menu bar

### US-002: Time Visibility
**As a user**, I want to see remaining time in the menu bar while working in any app, **so that** I can track time without switching context.

**Acceptance Criteria:**
- Timer displays in MM:SS format
- Updates every second
- Different visual states for idle/running/paused/finished

### US-003: Pause and Resume
**As a user**, I want to pause the timer and resume from where I left off, **so that** I can handle interruptions.

**Acceptance Criteria:**
- Pause button visible during running state
- Time freezes when paused
- Resume continues from remaining time

### US-004: Completion Notification
**As a user**, I want to be clearly notified when time is up, **so that** I know the session has ended.

**Acceptance Criteria:**
- macOS notification appears at 00:00
- Notification includes sound
- Works even when app is in background
- Menu bar shows "✓ Done" state

### US-005: Performance Guarantee
**As a user**, I want the app to not affect my system performance, **so that** I can work with heavy applications.

**Acceptance Criteria:**
- CPU usage <0.5% during operation
- RAM usage remains stable (no memory leaks)
- Works continuously for 8+ hours

---

## 4. Functional Requirements

### Timer Management
- **FR-001:** Default duration is 25 minutes
- **FR-002:** Supported presets: 1, 25, 45 minutes
- **FR-003:** Display format: MM:SS
- **FR-004:** Timer states: Idle, Running, Paused, Finished
- **FR-005:** Auto-stop at 00:00

### Controls
- **FR-006:** Start/Pause/Resume functionality
- **FR-007:** Reset to selected preset
- **FR-008:** Preset selection (disabled during running state)
- **FR-009:** Restart from finished state

### Notifications
- **FR-010:** Request notification permission on first launch
- **FR-011:** Send notification when timer completes
- **FR-012:** Include sound with notification
- **FR-013:** Show notifications even when app is active

### Menu Bar Display
- **FR-014:** Show formatted time in menu bar
- **FR-015:** Show state indicator (⏱, ⏸, ✓)
- **FR-016:** Update menu bar every second during countdown
- **FR-017:** Popover UI on click

---

## 5. Non-Functional Requirements

### Performance
- **NFR-001:** CPU usage <0.5% (idle and running)
- **NFR-002:** RAM usage <50 MB
- **NFR-003:** App launch time <1 second
- **NFR-004:** No memory leaks over 24+ hour operation
- **NFR-005:** Timer accuracy: ±1 second per hour

### Reliability
- **NFR-006:** 24+ hour continuous operation without crashes
- **NFR-007:** No timer drift (uses absolute time tracking)
- **NFR-008:** Thread-safe state updates

### Usability
- **NFR-009:** Intuitive UI requiring no learning curve
- **NFR-010:** Native macOS design language
- **NFR-011:** Dark/Light mode automatic switching
- **NFR-012:** Minimal, non-distracting visual design

### Compatibility
- **NFR-013:** macOS 12.0 (Monterey) or later
- **NFR-014:** Apple Silicon (M1/M2/M3) and Intel support

---

## 6. Technical Architecture

### Technology Stack
- **Language:** Swift
- **UI Framework:** SwiftUI
- **Timer Mechanism:** Timer with tolerance for power efficiency
- **State Management:** Combine ObservableObject pattern
- **Notifications:** UserNotifications framework
- **Logging:** OSLog (unified logging system)
- **Data Persistence:** UserDefaults (preset preference only)
- **Menu Bar:** NSStatusBar with NSPopover

### Architecture Components

```
pomodo-timer/
├── pomodo_timerApp.swift        - App entry point
├── AppDelegate.swift            - Menu bar & notification delegate
├── TimerManager.swift           - Timer logic & state (thread-safe)
├── NotificationService.swift    - Notification handling (SRP)
├── Constants.swift              - Centralized constants
└── MenuBarPopoverView.swift     - UI components
```

### Design Patterns
- **Protocol-based design:** NotificationServiceProtocol for testability
- **Dependency injection:** Services injected into managers
- **Single Responsibility Principle:** Each component has one clear purpose
- **Thread safety:** ensureMainThread() wrapper for UI updates
- **Separation of concerns:** Notifications, timer logic, UI separated

### State Machine
```
Idle → Running → Paused → Finished
  ↑       ↓         ↓         ↓
  └───────┴─────────┴─────────┘
```

---

## 7. Success Metrics

### Performance Metrics
- CPU usage: <0.5% (achieved: <0.5%)
- RAM usage: <50 MB (achieved: ~30-40 MB)
- Launch time: <1 second (achieved: <1 second)
- 24-hour stability: No crashes, no memory leaks

### Code Quality Metrics
- Total lines of code: ~740 lines
- Test coverage: Unit tests for core logic
- Documentation: All public APIs documented
- Architecture: Clean separation of concerns

---

## 8. Out of Scope (v1.0)

The following features are **NOT** included in v1.0:

1. ~~Sound notifications~~ ✅ **Implemented**
2. Custom duration input (only presets)
3. Statistics/History tracking
4. Pomodoro session counter
5. Long/short break system
6. Break timer
7. Keyboard shortcuts
8. Cloud sync/Account system
9. Theme customization (system theme only)
10. Animated progress bars

---

## 9. Implementation Status

### ✅ Completed Features
- Menu bar integration with popover
- Timer logic (start/pause/resume/reset)
- Preset selection (1, 25, 45 minutes)
- Native macOS notifications with sound
- Thread-safe state management
- Dark/Light mode support
- Persistent preset preference
- Structured logging
- Constants management
- Protocol-based architecture

### System Requirements
- macOS 12.0 (Monterey) or later
- Apple Silicon or Intel Mac

---

## 10. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | November 29, 2025 | Initial implementation completed |

---

**Last Updated:** November 29, 2025
