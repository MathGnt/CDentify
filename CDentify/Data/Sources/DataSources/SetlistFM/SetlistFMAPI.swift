//
//  SetlistFMAPI.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//
import Foundation

public class SetlistFMAPI {
    let apiKey = Bundle.main.infoDictionary?["SFM_API_KEY"] as! String
    let endpoint = "https://api.setlist.fm/rest/1.0/artist/"
    
    public init() {}
    
    public func fetchArtistSetlist(_ MBID: String) async throws -> [SetlistDTO] {
        guard let url = URL(string: endpoint + MBID + "/setlists") else {
            print("bad url")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("bad response for \(url)")
            throw URLError(.badServerResponse)
        }
        
        // Print du JSON
           if let jsonString = String(data: data, encoding: .utf8) {
               print("JSON Response: \(jsonString)")
           } else {
               print("Failed to convert data to string")
           }
        let decoder = JSONDecoder()
        return try decoder.decode(SetlistFMDTO.self, from: data).setlist
    }
}
