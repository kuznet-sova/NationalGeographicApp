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
    let buttonLabel: String?
    let sponsorContent: Bool
    let leadMedia: LeadMedia?
    let components: [Component]?
    
    enum CodingKeys: String, CodingKey {
        case id, uri
        case buttonLabel = "button_label"
        case sponsorContent = "sponsor_content"
        case leadMedia = "lead_media"
        case components
    }
}

struct LeadMedia: Decodable {
    let image: Image?
}

struct Image: Decodable {
    let uri: String?
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
