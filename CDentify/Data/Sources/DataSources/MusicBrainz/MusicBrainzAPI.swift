//
//  MusicBrainzAPI.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import DesignSystem

public class MusicBrainzAPI {
    let releaseEndpoint = "https://musicbrainz.org/ws/2/release/"
    let artistEndpoint = "https://musicbrainz.org/ws/2/artist/"
    let userAgent = Bundle.main.infoDictionary?["MB_AGENT"] as! String
    private let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 10
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config)
    }()
    public init() {}
    
    public func fetchReleaseID(_ barcode: String) async throws -> ReleaseDTO {
        print("fetching ID with barcode \(barcode)")
        guard var components = URLComponents(string: releaseEndpoint) else {
            print("badurl")
            throw URLError(.badURL)
        }
        print("before components")
        components.queryItems = [
            URLQueryItem(name: "query", value: "barcode:\(barcode)"),
            URLQueryItem(name: "fmt", value: "json"),
        ]
        print("after components")
        let data = try await performRequest(components: components)
        print("after perform request")
       
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromKebabCase
        print("after decoding kebab")
        guard let releaseID = try decoder.decode(ResponseIDDTO.self, from: data).releases.first?.id else {
            print("no release ID")
            throw NetworkError.noReleaseID
        }
        print("done release id \(releaseID)")
        return try await fetchRelease(releaseID)
    }
    
    public func fetchRelease(_ releaseID: String) async throws -> ReleaseDTO {
        guard var components = URLComponents(string: releaseEndpoint + releaseID) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "inc", value: "recordings+artist-credits+media+genres"),
            URLQueryItem(name: "fmt", value: "json")
        ]
        
        let data = try await performRequest(components: components)
       
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromKebabCase
        print("done release itself \(data)")
        return try decoder.decode(ReleaseDTO.self, from: data)
    }
    
    public func fetchBandMembers(_ artistID: String) async throws -> BandMemberDTO {
        guard var components = URLComponents(string: artistEndpoint + artistID) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "inc", value: "artist-rels"),
            URLQueryItem(name: "fmt", value: "json")
        ]
        
        let data = try await performRequest(components: components)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromKebabCase
        print("done band members \(data)")
        return try decoder.decode(BandMemberDTO.self, from: data)
    }
    
    private func performRequest(components: URLComponents) async throws -> Data {
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        print("date before URLSession is \(Date())")
        let (data, response) = try await urlSession.data(for: request)
        print("date after URLSession is \(Date())")
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}


enum NetworkError: Error {
    case noReleaseID
}
