//
//  MBReleaseDTO.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation

public struct MBReleaseDTO: Codable {
    public let id: String
    public let title: String
    public let packaging: String?
    public let date: String?
    public let country: String?
    public let artistCredit: [ArtistCreditDTO]
    public let media: [MediaDTO]
}

public struct ArtistCreditDTO: Codable {
    public let name: String
    public let artist: ArtistDTO
}

public struct ArtistDTO: Codable {
    public let id: String
    public let name: String
}

public struct MediaDTO: Codable {
    public let id: String
    public let format: String
    public let position: Int
    public let trackCount: Int
    public let tracks: [TrackDTO]
}

public struct TrackDTO: Codable {
    public let id: String
    public let title: String
    public let length: Int? //ms
    public let position: Int
}
