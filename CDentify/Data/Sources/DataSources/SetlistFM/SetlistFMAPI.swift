//
//  SetlistFMAPI.swift
//  Data
//
//  Created by Mathis Gaignet on 29/07/2025.
//
import Foundation

public class SetlistFMDS {
    let apiKey = Bundle.main.infoDictionary?["SFM_API_KEY"] as! String
    let endpoint = "https://api.setlistfm.com/rest/1.0/"
}
