//
//  Releasable.swift
//  Domain
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import Entities

public protocol Releasable {
    func mapToDomain(_ barcode: String) async throws -> CD
}
