//
//  ScannerUseCase.swift
//  Domain
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import Protocols
import Entities

public class ScannerUseCase {
    let repository: Releasable
    
    public init(repository: Releasable) {
        self.repository = repository
    }
    
    public func getCD(_ barcode: String) async throws -> CD {
        try await repository.mapToDomain(barcode)
    }
}
