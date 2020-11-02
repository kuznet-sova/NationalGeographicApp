//
//  Categorie.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 01.11.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import Foundation

struct Category {
    let nameCategorie: String
}

extension Category {
    static func getCategorie() -> [Category] {
        var categoriesList = [Category]()

        for index in 0 ..< Categories().nameCategories.count {
            categoriesList.append (
                Category (
                    nameCategorie: Categories().nameCategories[index]
                )
            )
        }
        return categoriesList
    }
}

