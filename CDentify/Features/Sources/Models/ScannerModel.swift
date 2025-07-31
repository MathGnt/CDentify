//
//  ScannerModel.swift
//  Features
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import AVFoundation
import VisionKit
import Observation
/// Own dependencies
import UseCases
import Entities
import SwiftUI

@Observable
public class ScannerModel: DataScannerViewControllerDelegate {
    public let scannerController = DataScannerViewController(
        recognizedDataTypes: [.barcode(symbologies: [.ean13])],
        qualityLevel: .balanced,
        recognizesMultipleItems: false
    )
    
    public var cd: CD?
    public var askedForScan = false
    public var showCD = false
    private var barcodeValue: String?
    let useCase: ScannerUseCase
    
    public init(useCase: ScannerUseCase) {
        self.useCase = useCase
        scannerController.delegate = self
    }
    
    public func startScan() {
        do {
            askedForScan = true
            try scannerController.startScanning()
        } catch {
            print("error while starting the scan")
        }
    }
    
    public func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        let recognizedBarcode = addedItems.first
        if case let .barcode(barcode) = recognizedBarcode {
            if let barcodeValue = barcode.payloadStringValue {
                scannerController.stopScanning()
                askedForScan = false
                let cleaned = cleanBarcode(barcodeValue)
                self.barcodeValue = cleaned
                print("new barcode read: \(cleaned)")
            }
        }
    }
    
    public func processBarcode() async {
        guard let barcodeValue else { return }
        do {
            cd = try await useCase.getCD(barcodeValue)
        } catch {
            print("the scan failed")
        }
    }
    
    private func cleanBarcode(_ barcode: String) -> String {
        if barcode.hasPrefix("0") && barcode.count == 13 {
            return String(barcode.dropFirst())
        }
        return barcode
    }
}
