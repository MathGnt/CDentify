//
//  Home.swift
//  Features
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import SwiftUI

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

#Preview {
    NavigationStack {
        Home()
    }
}
