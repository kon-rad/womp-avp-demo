//
//  wompDemoApp.swift
//  wompDemo
//
//  Created by Konrad Gnat on 3/14/24.
//

import SwiftUI

@main
struct wompDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "modelSpace") {
            ModelView(modelName: "hot-dog.usdz", x: 0, y: 0, z: -1) // Adjust position as needed
        }
    }
}
