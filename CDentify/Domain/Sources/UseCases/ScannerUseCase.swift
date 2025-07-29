//
//  ScannerUseCase.swift
//  Domain
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import Protocols

public class ScannerUseCase {
    let repository: Releasable
    
    public init(repository: Releasable) {
        self.repository = repository
    }
}
