//
//  pomodo_timerApp.swift
//  pomodo-timer
//
//  Created by Berkay Çit on 29.11.2025.
//

import SwiftUI

@main
struct pomodo_timerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
