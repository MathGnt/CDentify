//
//  ReleaseRepo.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import DataSources
import Entities
import Protocols

class ReleaseRepo: Releasable {
    let dataSource: MusicBrainzAPI
    
    init(dataSource: MusicBrainzAPI) {
        self.dataSource = dataSource
    }
    
    func mapToDomain(_ barcode: String) async throws {
        let apiResponse = try await dataSource.fetchReleaseID(barcode)

        let domainRelease = CD(title: apiResponse.title, artist: getArtists(artists: apiResponse.artistCredit), length: <#T##Int#>, releaseDate: <#T##Date#>, recordingData: getRecordingDatas())
    }
    
    private func getArtists(artists: [ArtistCreditDTO]) -> [Artist] {
        
    }
    
    private func getRecordingDatas() -> [RecordingData] {
        
    }
}

