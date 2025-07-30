//
//  File.swift
//  Domain
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import SwiftData
import CoreLocation

public struct CD {
    public var title: String
    public var artist: Artist
    public var genre: String
    public var tracks: [Track]
    public var length: Int
    public var artwork: Data?
    public var packaging: String?
    public var releaseDate: String
    public var averagePrice: Double?
    
    public init(title: String, artist: Artist, genre: String, tracks: [Track], length: Int, artwork: Data? = nil, packaging: String? = nil, releaseDate: String, averagePrice: Double? = nil) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.tracks = tracks
        self.length = length
        self.artwork = artwork
        self.packaging = packaging
        self.releaseDate = releaseDate
        self.averagePrice = averagePrice
    }
}

public struct Artist {
    public var name: String
    public var members: [String]
    public var recentShows: [Show]
    
    public init(name: String, members: [String], recentShows: [Show]) {
        self.name = name
        self.members = members
        self.recentShows = recentShows
    }
}

public struct Track {
    public var title: String
    public var position: Int
    public var duration: Int
    
    public init(title: String, position: Int, duration: Int) {
        self.title = title
        self.position = position
        self.duration = duration
    }
}

public struct Show {
    public var date: String
    public var location: Location
    public var playedSongs: [String]
    
    public init(date: String, location: Location, playedSongs: [String]) {
        self.date = date
        self.location = location
        self.playedSongs = playedSongs
    }
}

public struct Location {
    public var venue: String
    public var city: String
    public var coordinates: CLLocationCoordinate2D
    
    public init(venue: String, city: String, coordinates: CLLocationCoordinate2D) {
        self.venue = venue
        self.city = city
        self.coordinates = coordinates
    }
}
