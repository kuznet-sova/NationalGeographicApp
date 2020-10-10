//
//  Storie.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

struct Storie: Decodable {
    let id: String
    let leadMedia: LeadMedia?
    let components: [Component]?
}

struct LeadMedia: Decodable {
    let contentType: String?
    let immersiveLead: ImmersiveLead?
}

struct ImmersiveLead: Decodable {
    let title: String?
}

struct Component: Decodable {
    let title: Title?
}

struct Title: Decodable {
    let text: String?
}
