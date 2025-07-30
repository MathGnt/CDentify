//
//  MBBandMemberDTO.swift
//  Data
//
//  Created by Mathis Gaignet on 30/07/2025.
//

import Foundation

public struct BandMemberDTO: Codable {
    public let relations: [RelationDTO]
}

public struct RelationDTO: Codable {
    public let artist: MemberDTO
}

public struct MemberDTO: Codable {
    public let name: String
}

