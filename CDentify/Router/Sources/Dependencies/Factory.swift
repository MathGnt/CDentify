//
//  File.swift
//  Router
//
//  Created by Mathis Gaignet on 31/07/2025.
//

import Foundation
import DataSources
import Repositories
import Protocols
import UseCases

public struct DependencyFactory {
    static func makeMusicBrainzAPI() -> MusicBrainzAPI {
        MusicBrainzAPI()
    }
    
    static func makeSetlistFMAPI() -> SetlistFMAPI {
        SetlistFMAPI()
    }
    
    static func makeMockReleaseRepo() -> Releasable {
        MockRelease()
    }
    
    public static func makeMockScannerUseCase() -> ScannerUseCase {
        ScannerUseCase(repository: makeMockReleaseRepo())
    }

    static func makeReleaseRepository() -> Releasable {
        ReleaseRepo(
            dataSource: makeMusicBrainzAPI(),
            setlistDataSource: makeSetlistFMAPI()
        )
    }
    
    public static func makeScannerUseCase() -> ScannerUseCase {
        ScannerUseCase(repository: makeReleaseRepository())
    }
}
