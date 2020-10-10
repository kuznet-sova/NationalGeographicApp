//
//  Storie.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

struct Storie: Decodable {
    let id: String
    let uri: String?
    let sponsorContent: Bool
    let components: [Component]?
    
    enum CodingKeys: String, CodingKey {
        case id, uri
        case sponsorContent = "sponsor_content"
//        case leadMedia = "lead_media"
        case components
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        uri = try values.decode(String.self, forKey: .uri)
        sponsorContent = try values.decode(Bool.self, forKey: .sponsorContent)
        components = try values.decode(Array.self, forKey: .components)
    }
}

struct Component: Decodable {
    let title: Title?
    let dek: Dek?
    let kicker: Kicker?
}

struct Title: Decodable {
    let text: String?
}

struct Dek: Decodable {
    let text: String?
}

struct Kicker: Decodable {
    let vertical: Vertical?
}

struct Vertical: Decodable {
    let name: String?
    let uri: String?
}
