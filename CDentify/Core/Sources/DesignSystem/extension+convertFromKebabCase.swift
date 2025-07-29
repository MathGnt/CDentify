//
//  extension+convertFromKebabCase.swift
//  Core
//
//  Created by Mathis Gaignet on 29/07/2025.
//
import Foundation

extension JSONDecoder.KeyDecodingStrategy {
    public static var convertFromKebabCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingPath in
            let key = codingPath.last!.stringValue
            
            let components = key.components(separatedBy: "-")
            guard components.count > 1 else {
                return AnyCodingKey(stringValue: key)
            }
            
            let camelCase = components.first! + components.dropFirst().map { $0.capitalized }.joined()
            return AnyCodingKey(stringValue: camelCase)
        }
    }
    
    // Helper struct
    public nonisolated struct AnyCodingKey: CodingKey {
        public var stringValue: String
        public var intValue: Int?
        
        public init(stringValue: String) {
            self.stringValue = stringValue
        }
        
        public init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = String(intValue)
        }
    }
}
