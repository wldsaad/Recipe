//
//  JsonModel.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import Foundation

struct JsonModel: Decodable {
    var count: Int?
    var hits: [HitObject]?
}

struct HitObject: Decodable {
    var recipe: Recipe?
}

struct Recipe: Decodable {
    var uri: String?
    var label: String?
    var image: String?
    var url: String?
    var shareAs: String?
    var ingredientLines: [String]?
    var calories: Double?
    var totalNutrients: Nutrients?
    var totalDaily: Nutrients?

}

struct Nutrients: Decodable {
    var ENERC_KCAL: Enegery?
    var FAT: Fat?
    var CHOCDF: Carbohydrate?
    var PROCNT: Protein?
    var FIBTG: Fiber?
    var SUGAR: Sugar?
    var CHOLE: Cholesterol?
    var NA: Sodium?
    var CA: Calcium?
    var MG: Magnesium?
    var K: Potassium?
    var FE: Iron?
    var ZN: Zinc?
    var P: Phosphorus?

}

struct Enegery: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Fat: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Carbohydrate: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Protein: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Fiber: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Sugar: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Cholesterol: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Sodium: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Calcium: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Magnesium: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Potassium: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Iron: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Zinc: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct Phosphorus: Decodable {
    var label: String?
    var quantity: Double?
    var unit: String?
}







