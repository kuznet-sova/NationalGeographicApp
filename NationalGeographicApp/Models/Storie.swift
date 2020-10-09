//
//  Storie.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

struct Storie: Decodable {
    let id: String?
    let uri: String?
    let sponsorContent: Bool
    let sponsorContentLabel: String?
    let title: String?
    let description: String?
}
