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
    let buttonLabel: String
    let sponsorContent: Bool
    let sponsorContentLabel: String?
    let leadMedia: LeadMedia?
    let components: [Component]?
    
    enum CodingKeys: String, CodingKey {
        case id, uri
        case buttonLabel = "button_label"
        case sponsorContent = "sponsor_content"
        case sponsorContentLabel = "sponsor_content_label"
        case leadMedia = "lead_media"
        case components
    }
}

struct LeadMedia: Decodable {
    let image: Image?
    let video: Video?
    let immersiveLead: ImmersiveLead?
    
    enum CodingKeys: String, CodingKey {
        case image, video
        case immersiveLead = "immersive_lead"
    }
}

struct Video: Decodable {
    let image: Image?
}

struct Image: Decodable {
    let uri: String?
}

struct ImmersiveLead: Decodable {
    let immersiveLeadMedia: ImmersiveLeadMedia?

    enum CodingKeys: String, CodingKey {
        case immersiveLeadMedia = "lead_media"
    }
}

struct ImmersiveLeadMedia: Decodable {
    let image: Image?
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
