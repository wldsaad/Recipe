//
//  SelectionRecipeDelegate.swift
//  Recipe
//
//  Created by Waleed Saad on 1/14/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import Foundation

protocol SelectionRecipeDelegate {
    func getRecipe(
        name: String,
        imageData: Data,
        ingredients: String,
        calories: String,
        fatsTotal: String, fatsDaily: String,
        carbohydratesTotal: String, carbohydratesDaily: String,
        proteinTotal: String, proteinDaily: String,
        fiberTotal: String, fiberDaily: String,
        sugarTotal: String, sugarDaily: String,
        cholesterolTotal: String, cholesterolDaily: String,
        sodiumTotal: String, sodiumDaily: String,
        calciumTotal: String, calciumDaily: String,
        magnesiumTotal: String, magnesiumDaily: String,
        potassiumTotal: String, potassiumDaily: String,
        ironTotal: String, ironDaily: String,
        zincTotal: String, zincDaily: String,
        phosphorusTotal: String, phosphorusDaily: String,
        shareAs: String
    )
}
