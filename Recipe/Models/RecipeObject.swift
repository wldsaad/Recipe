//
//  RecipeObject.swift
//  Recipe
//
//  Created by Waleed Saad on 1/13/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import Foundation
import RealmSwift

class RecipeObject: Object{
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var imageData = Data()
    @objc dynamic var ingredients = ""
    @objc dynamic var calories = ""
    @objc dynamic var fatsTotal = ""
    @objc dynamic var fatsDaily = ""
    @objc dynamic var carbohydratesTotal = ""
    @objc dynamic var carbohydratesDaily = ""
    @objc dynamic var proteinTotal = ""
    @objc dynamic var proteinDaily = ""
    @objc dynamic var fiberTotal = ""
    @objc dynamic var fiberDaily = ""
    @objc dynamic var sugarTotal = ""
    @objc dynamic var sugarDaily = ""
    @objc dynamic var cholesterolTotal = ""
    @objc dynamic var cholesterolDaily = ""
    @objc dynamic var sodiumTotal = ""
    @objc dynamic var sodiumDaily = ""
    @objc dynamic var calciumTotal = ""
    @objc dynamic var calciumDaily = ""
    @objc dynamic var magnesiumTotal = ""
    @objc dynamic var magnesiumDaily = ""
    @objc dynamic var potassiumTotal = ""
    @objc dynamic var potassiumDaily = ""
    @objc dynamic var ironTotal = ""
    @objc dynamic var ironDaily = ""
    @objc dynamic var zincTotal = ""
    @objc dynamic var zincDaily = ""
    @objc dynamic var phosphorusTotal = ""
    @objc dynamic var phosphorusDaily = ""
}
