//
//  SwiftUIView.swift
//  Features
//
//  Created by Mathis Gaignet on 30/07/2025.
//

import SwiftUI
import VisionKit

public struct Scanner: UIViewControllerRepresentable {
    let model: ScannerModel
    
    public init(model: ScannerModel) {
        self.model = model
    }
    
    public func makeUIViewController(context: Context) -> DataScannerViewController {
        return model.scannerController
    }
    
    public func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // No update for now
    }
    
    public typealias UIViewControllerType = DataScannerViewController
}
