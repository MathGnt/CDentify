//
//  MockRelease.swift
//  Data
//
//  Created by Mathis Gaignet on 31/07/2025.
//

import Foundation
import CoreLocation
import Protocols
import Entities

public class MockRelease: Releasable {
    public init () {}
    public func mapToDomain(_ barcode: String) async throws -> CD {
        let location = Location(venue: "Kafe 44", city: "Stockholm", coordinates: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686))
        let recentShow: [Show] = [
            .init(date: "2002-09-15", location: location, playedSongs: ["California White", "Crazy Nights", "Miss Pain", "Riot In Everyone"])
        ]
        let artist = Artist(name: "Crashdiet", members: ["Dave Lepard", "Martin Sweet", "Peter London", "Eric Young"], recentShows: recentShow)
        let tracks: [Track] = [
            .init(title: "Knokk Em Down", position: 1, duration: 195000),
            .init(title: "Riot in Everyone", position: 1, duration: 182547),
            .init(title: "Queen Obscene", position: 1, duration: 187564),
            .init(title: "Breakin the Chainz", position: 1, duration: 184752),
            .init(title: "Needle in your Eye", position: 1, duration: 200145),
            .init(title: "Tikket", position: 1, duration: 194578),
            .init(title: "Out of Line", position: 1, duration: 192514),
            .init(title: "It's a Miracle", position: 1, duration: 188879),
            .init(title: "Straight Outta Hell", position: 1, duration: 186592),
            .init(title: "Back on Trakk", position: 1, duration: 199457),
            .init(title: "Tomorrow", position: 1, duration: 179845)
        ]
        return CD(title: "Rest in Sleaze", artist: artist, genre: "Sleaze", tracks: tracks, length: tracks.reduce(0) { $0 + $1.duration }, releaseDate: "2005-05-20")
    }
}
