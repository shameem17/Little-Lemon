//
//  MenuCategory.swift
//  LittelLemon
//
//  Created by Shameem on 2/6/24.
//

import Foundation

enum MenuCategory: String, CaseIterable{
    case food = "Food"
    case drink = "Drink"
    case dessert = "Dessert"
}

enum SortingCategory: String, CaseIterable{
    case mostPopular = "Most Popular"
    case price = "Price $-$$$"
    case name = "A-Z"
}
