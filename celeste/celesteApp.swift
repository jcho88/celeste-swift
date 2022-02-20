//
//  celesteApp.swift
//  celeste
//
//  Created by Justin Cho on 1/18/21.
//

import SwiftUI

@main
struct celesteApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
