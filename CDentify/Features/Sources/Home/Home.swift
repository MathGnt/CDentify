//
//  Home.swift
//  Features
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import SwiftUI
import BarcodeScanner

/// The home view of the app where the user can make a new scan, see recent ones..
public struct Home: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .navigationTitle("Home")
        .toolbar {
            ScanButton()
        }
    }
}
extension Home {
    struct ScanButton: ToolbarContent {
        @Environment(ScannerModel.self) private var model

        var body: some ToolbarContent {
            @Bindable var model = model
            ToolbarItem {
                Button("Scan", systemImage: "barcode.viewfinder") {
                    model.startScan()
                }
                .sheet(isPresented: $model.askedForScan, onDismiss: {
                    Task {
                        await model.processBarcode()
                    }
                }) {
                    Scanner(model: model)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        Home()
    }
}
