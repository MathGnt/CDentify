//
//  File.swift
//  Domain
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import SwiftData

@Model
public final class CD {
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Artist.CD)
    var artist: [Artist]
    var tracks: [Track]
    var length: Int
    @Attribute(.externalStorage)
    var artwork: Data?
    var packaging: String?
    var releaseDate: Date
    var averagePrice: Double?
    var recordingData: [RecordingData]
    
    public init(title: String, artist: [Artist], tracks: [Track], length: Int, artwork: Data? = nil, packaging: String? = nil, releaseDate: Date, averagePrice: Double? = nil, recordingData: [RecordingData]) {
        self.title = title
        self.artist = artist
        self.tracks = tracks
        self.length = length
        self.artwork = artwork
        self.packaging = packaging
        self.releaseDate = releaseDate
        self.averagePrice = averagePrice
        self.recordingData = recordingData
    }
}

@Model
public final class Artist {
    var name: String
    var members: [String]
    @Relationship(deleteRule: .cascade, inverse: \Show.artist)
    var recentShows: [Show]
    
    var CD: CD?
    
    public init(name: String, members: [String], recentShows: [Show], CD: CD? = nil) {
        self.name = name
        self.members = members
        self.recentShows = recentShows
        self.CD = CD
    }
}

@Model
public final class Track {
    var title: String
    var position: Int
    var duration: Int
    
    public init(title: String, position: Int, duration: Int) {
        self.title = title
        self.position = position
        self.duration = duration
    }
}

@Model
public final class Show {
    var date: Date
    var venue: String
    var playedSongs: [String]
    
    var artist: Artist?
    
    public init(date: Date, venue: String, playedSongs: [String]) {
        self.date = date
        self.venue = venue
        self.playedSongs = playedSongs
    }
}

@Model
public final class RecordingData {
    var producer: String?
    var audioEngineer: String?
    var recordingStudio: String?
    
    public init(producer: String? = nil, audioEngineer: String? = nil, recordingStudio: String? = nil) {
        self.producer = producer
        self.audioEngineer = audioEngineer
        self.recordingStudio = recordingStudio
    }
}
