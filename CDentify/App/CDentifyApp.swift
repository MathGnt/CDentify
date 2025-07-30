//
//  CDentifyApp.swift
//  CDentify
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import SwiftUI
import Home

@main
struct CDentifyApp: App {
    @State private var scannerModel = DependencyFactory.makeScannerModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Home()
            }
            .environment(scannerModel)
        }
    }
}
