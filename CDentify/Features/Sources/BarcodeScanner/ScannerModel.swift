//
//  ScannerModel.swift
//  Features
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import AVFoundation
/// Own dependencies
import UseCases

class ScannerModel {
    let useCase: ScannerUseCase
    
    init(useCase: ScannerUseCase) {
        self.useCase = useCase
    }
}
