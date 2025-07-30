//
//  SetlistDTO.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation

public struct SetlistFMDTO: Codable {
    public let setlist: [SetlistDTO]
}

public struct SetlistDTO: Codable {
    public let id: String
    public let eventDate: String
    public let venue: VenueDTO
    public let sets: SetsDTO
}

public struct VenueDTO: Codable {
    public let name: String
    public let city: CityDTO
}

public struct CityDTO: Codable {
    public let name: String
    public let coords: CoordsDTO
    public let country: CountryDTO
}

public struct CoordsDTO: Codable {
    public let lat: Double
    public let long: Double
}

public struct CountryDTO: Codable {
    public let name: String
}

public struct SetsDTO: Codable {
    public let set: [SetDTO]
}

public struct SetDTO: Codable {
    public let song: [SongDTO]
}

public struct SongDTO: Codable {
    public let name: String
}
