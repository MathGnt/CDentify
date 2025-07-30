//
//  ReleaseRepo.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import CoreLocation
import DataSources
import Entities
import Protocols

public class ReleaseRepo: Releasable {
    let brainzDataSource: MusicBrainzAPI
    let setlistDataSource: SetlistFMAPI
    
    public init(dataSource: MusicBrainzAPI, setlistDataSource: SetlistFMAPI) {
        self.brainzDataSource = dataSource
        self.setlistDataSource = setlistDataSource
    }
    
    public func mapToDomain(_ barcode: String) async throws -> CD {
        print("try to map")
        let apiResponse = try await brainzDataSource.fetchReleaseID(barcode)
        print("api response is \(apiResponse)")
        guard let firstMedia = apiResponse.media.first else {
            print("no first media")
            throw RepoErrors.noMedia
        }
        
        let tracks = mapTracks(firstMedia.tracks)
        async let artistsAndGenres = mapArtistsAndGenres(apiResponse.artistCredit)
        print("passed let and async")
        let domainRelease = try await CD(title: apiResponse.title, artist: artistsAndGenres.0, genre: artistsAndGenres.1, tracks: tracks, length: 0, packaging: apiResponse.packaging ?? "", releaseDate: apiResponse.date ?? "")
        print("created domain release")
        return domainRelease
    }

    private func mapArtistsAndGenres(_ artists: [ArtistCreditDTO]) async throws -> (Artist, String) {
        guard let firstArtist = artists.first else {
            throw RepoErrors.noArtist
        }
        print("before twice async let")
        async let members = brainzDataSource.fetchBandMembers(firstArtist.artist.id)
        async let recentShows = setlistDataSource.fetchArtistSetlist(firstArtist.artist.id)
        
        let artist = try await Artist(name: firstArtist.name, members: mapMembers(members.relations), recentShows: mapRecentShows(recentShows))
        let genre = firstArtist.artist.genres.first?.name
        print("before returning artist and genres")
        return (artist, genre ?? "Unknown")
    }
    
    private func mapMembers(_ allMembers: [RelationDTO]) -> [String] {
        var membersNames: [String] = []
        allMembers.forEach { member in
            membersNames.append(member.artist.name)
        }
        return membersNames
    }
    
    private func mapTracks(_ tracks: [TrackDTO]) -> [Track] {
        var tracksDomain: [Track] = []
        tracks.forEach { track in
            let newTrack = Track(title: track.title, position: track.position, duration: track.length ?? 0)
            tracksDomain.append(newTrack)
        }
        return tracksDomain
    }
    
    private func mapRecentShows(_ recentShow: [SetlistDTO]) async throws -> [Show] {
        var showArray: [Show] = []
        recentShow.forEach { show in
            let location = Location(venue: show.venue.name, city: show.venue.city.name, coordinates: CLLocationCoordinate2D(latitude: show.venue.city.coords.lat, longitude: show.venue.city.coords.long))
            guard let playedSongs = show.sets.set.first?.song.map(\.name) else { return }
            let showDomain = Show(date: show.eventDate, location: location, playedSongs: playedSongs)
            showArray.append(showDomain)
        }
        return showArray
    }
}

enum RepoErrors: Error {
    case noMedia
    case noArtist
}
