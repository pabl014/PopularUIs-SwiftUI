//
//  PopularUIs_SwiftUIApp.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 08/04/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct PopularUIs_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}
