//
//  ScannerTests.swift
//  Features
//
//  Created by Mathis Gaignet on 31/07/2025.
//

import Foundation
import Testing
import Dependencies
import Models

struct ScannerTests {
    let model = ScannerModel(useCase: DependencyFactory.makeMockScannerUseCase())
}
