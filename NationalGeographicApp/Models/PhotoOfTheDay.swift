//
//  PhotoOfTheDay.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 03.11.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

struct PhotoOfTheDay: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let image: Photo?
}

struct Photo: Decodable {
    let uri: String?
}
