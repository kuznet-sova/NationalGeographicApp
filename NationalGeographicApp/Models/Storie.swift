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
    let sponsorContentLabel: String?
    let components: [Component]?
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
