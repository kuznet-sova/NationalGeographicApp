//
//  Category.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 01.11.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

struct Category {
    let nameCategory: String
}

extension Category {
    static func getCategory() -> [Category] {
        var categoriesList = [Category]()

        for index in 0 ..< Categories().nameCategories.count {
            categoriesList.append (
                Category (
                    nameCategory: Categories().nameCategories[index]
                )
            )
        }
        return categoriesList
    }
}

