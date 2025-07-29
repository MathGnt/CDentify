//
//  MusicBrainzAPI.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//

import Foundation
import DesignSystem

public class MusicBrainzAPI {
    let endpoint = "https://musicbrainz.org/ws/2/release/"
    let userAgent = Bundle.main.infoDictionary?["MB_AGENT"] as! String
    
    public func fetchReleaseID(_ barcode: String) async throws -> MBReleaseDTO {
        guard var components = URLComponents(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "query", value: "barcode: \(barcode)"),
            URLQueryItem(name: "fmt", value: "json"),
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromKebabCase
        let releaseID = try decoder.decode(MBReleaseIDDTO.self, from: data).id
        
        return try await fetchRelease(releaseID)
    }
    
    public func fetchRelease(_ releaseID: String) async throws -> MBReleaseDTO {
        guard var components = URLComponents(string: endpoint + releaseID) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "inc", value: "recordings+artist-credits+labels+media"),
            URLQueryItem(name: "fmt", value: "json")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(MBReleaseDTO.self, from: data)
    }
}

