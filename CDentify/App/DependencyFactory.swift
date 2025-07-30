//
//  DependencyFactory.swift
//  CDentify
//
//  Created by Mathis Gaignet on 30/07/2025.
//

import Foundation
import DataSources
import Repositories
import UseCases
import Protocols
import BarcodeScanner

/// Factory responsible for creating and wiring dependencies
/// Follows Composition Root pattern for Clean Architecture
struct DependencyFactory {
    static func makeMusicBrainzAPI() -> MusicBrainzAPI {
        MusicBrainzAPI()
    }
    
    static func makeSetlistFMAPI() -> SetlistFMAPI {
        SetlistFMAPI()
    }

    static func makeReleaseRepository() -> Releasable {
        ReleaseRepo(
            dataSource: makeMusicBrainzAPI(),
            setlistDataSource: makeSetlistFMAPI()
        )
    }
    
    static func makeScannerUseCase() -> ScannerUseCase {
        ScannerUseCase(repository: makeReleaseRepository())
    }
    
    static func makeScannerModel() -> ScannerModel {
        ScannerModel(useCase: makeScannerUseCase())
    }
}
