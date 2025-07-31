//
//  SwiftUIView.swift
//  Features
//
//  Created by Mathis Gaignet on 30/07/2025.
//

import SwiftUI
import VisionKit
import Models
import Dependencies

struct Scanner: UIViewControllerRepresentable {
    let model: ScannerModel
    
    init(model: ScannerModel) {
        self.model = model
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        return model.scannerController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // No update for now
    }
    
    typealias UIViewControllerType = DataScannerViewController
}


struct ScanButton: ToolbarContent {
    @State private var model = ScannerModel(useCase: DependencyFactory.makeScannerUseCase())
    @Environment(\.dismiss) private var dismiss
    
    var body: some ToolbarContent {
        @Bindable var model = model
        
        ToolbarItem {
            Button("Scan", systemImage: "barcode.viewfinder") {
                model.startScan()
            }
            .sheet(isPresented: $model.askedForScan, onDismiss: {
                Task {
                    await model.processBarcode()
                    model.showCD = true
                }
            }) {
                Scanner(model: model)
            }
            .sheet(isPresented: $model.showCD) {
                if let cd = model.cd {
                    CDDetail(cd: cd)
                } else {
                    ContentUnavailableView("No disc found!", systemImage: "opticaldisc.fill", description: Text("This disc is not registered in our database"))
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

