//
//  Categorie.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 01.11.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import Foundation

struct Categorie {
    let nameCategorie: String
}

extension Categorie {
    static func getCategorie() -> [Categorie] {
        var categoriesList = [Categorie]()

        for index in 0 ..< Categories().nameCategories.count {
            categoriesList.append (
                Categorie (
                    nameCategorie: Categories().nameCategories[index]
                )
            )
        }
        return categoriesList
    }
}

