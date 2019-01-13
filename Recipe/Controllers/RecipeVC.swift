//
//  RecipeVC.swift
//  Recipe
//
//  Created by Waleed Saad on 1/13/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController, SelectionRecipe {
    
    


    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeIngredientsTextView: UITextView!
    @IBOutlet weak var recipeKCaloriesLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbodydratesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var calciumLabel: UILabel!
    @IBOutlet weak var magnesiumLabel: UILabel!
    @IBOutlet weak var potassiumLabel: UILabel!
    @IBOutlet weak var ironLabel: UILabel!
    @IBOutlet weak var zincLabel: UILabel!
    @IBOutlet weak var phosphorusLabel: UILabel!
    @IBOutlet weak var fatsCircularLabel: UILabel!
    @IBOutlet weak var carbodydratesCicularLabel: UILabel!
    @IBOutlet weak var proteinCircularLabel: UILabel!
    @IBOutlet weak var fiberCircularLabel: UILabel!
    @IBOutlet weak var sugarCircularLabel: UILabel!
    @IBOutlet weak var cholesterolCircularLabel: UILabel!
    @IBOutlet weak var sodiumCircularLabel: UILabel!
    @IBOutlet weak var calciumCircularLabel: UILabel!
    @IBOutlet weak var magnesiumCircularLabel: UILabel!
    @IBOutlet weak var potassiumCircularLabel: UILabel!
    @IBOutlet weak var ironCircularLabel: UILabel!
    @IBOutlet weak var zincCircularLabel: UILabel!
    @IBOutlet weak var phosphorusCircularLabel: UILabel!
    @IBOutlet weak var fatsCircularView: CircleProgressView!
    @IBOutlet weak var carbohydratesCircularView: CircleProgressView!
    @IBOutlet weak var proteinCircularView: CircleProgressView!
    @IBOutlet weak var fiberCircularView: CircleProgressView!
    @IBOutlet weak var sugarCircularView: CircleProgressView!
    @IBOutlet weak var cholesterolCicularView: CircleProgressView!
    @IBOutlet weak var sodiumCircularView: CircleProgressView!
    @IBOutlet weak var calciumCircularView: CircleProgressView!
    @IBOutlet weak var magnesiumCircularView: CircleProgressView!
    @IBOutlet weak var potassiumCircularView: CircleProgressView!
    @IBOutlet weak var ironCircularView: CircleProgressView!
    @IBOutlet weak var zincCircularView: CircleProgressView!
    @IBOutlet weak var phosphorusCircularView: CircleProgressView!
    
    
    private var imageData = Data()
    private var ingredients = ""
    private var calories = ""
    private var fatsTotal = ""
    private var fatsDaily = ""
    private var carbohydratesTotal = ""
    private var carbohydratesDaily = ""
    private var proteinTotal = ""
    private var proteinDaily = ""
    private var fiberTotal = ""
    private var fiberDaily = ""
    private var sugarTotal = ""
    private var sugarDaily = ""
    private var cholesterolTotal = ""
    private var cholesterolDaily = ""
    private var sodiumTotal = ""
    private var sodiumDaily = ""
    private var calciumTotal = ""
    private var calciumDaily = ""
    private var magnesiumTotal = ""
    private var magnesiumDaily = ""
    private var potassiumTotal = ""
    private var potassiumDaily = ""
    private var ironTotal = ""
    private var ironDaily = ""
    private var zincTotal = ""
    private var zincDaily = ""
    private var phosphorusTotal = ""
    private var phosphorusDaily = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews(){
        recipeImageView.image = UIImage(data: imageData)
        recipeIngredientsTextView.text = ingredients
        recipeKCaloriesLabel.text = calories + " cal."
        fatsLabel.text = fatsTotal
        fatsCircularLabel.text = fatsDaily
        fatsCircularView.progress = ((Double(fatsDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(fatsDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        carbodydratesLabel.text = carbohydratesTotal
        carbodydratesCicularLabel.text = carbohydratesDaily
        carbohydratesCircularView.progress = ((Double(carbohydratesDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(carbohydratesDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        proteinLabel.text = proteinTotal
        proteinCircularLabel.text = proteinDaily
        proteinCircularView.progress = ((Double(proteinDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(proteinDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        fiberLabel.text = fiberTotal
        fiberCircularLabel.text = fiberDaily
        fiberCircularView.progress = ((Double(fiberDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(fiberDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        sugarLabel.text = sugarTotal
        sugarCircularLabel.text = sugarDaily
        sugarCircularView.progress = ((Double(sugarDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(sugarDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        cholesterolLabel.text = cholesterolTotal
        cholesterolCircularLabel.text = cholesterolDaily
        cholesterolCicularView.progress = ((Double(cholesterolDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(cholesterolDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        sodiumLabel.text = sodiumTotal
        sodiumCircularLabel.text = sodiumDaily
        sodiumCircularView.progress = ((Double(sodiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(sodiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        calciumLabel.text = calciumTotal
        calciumCircularLabel.text = calciumDaily
        calciumCircularView.progress = ((Double(calciumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(calciumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        magnesiumLabel.text = magnesiumTotal
        magnesiumCircularLabel.text = magnesiumDaily
        magnesiumCircularView.progress = ((Double(magnesiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(magnesiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        potassiumLabel.text = potassiumTotal
        potassiumCircularLabel.text = potassiumDaily
        potassiumCircularView.progress = ((Double(potassiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(potassiumDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        ironLabel.text = ironTotal
        ironCircularLabel.text = ironDaily
        ironCircularView.progress = ((Double(ironDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(ironDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        zincLabel.text = zincTotal
        zincCircularLabel.text = zincDaily
        zincCircularView.progress = ((Double(zincDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(zincDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)
        phosphorusLabel.text = phosphorusTotal
        phosphorusCircularLabel.text = phosphorusDaily
        phosphorusCircularView.progress = ((Double(phosphorusDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0) >= 1 ? 1.0 : ((Double(phosphorusDaily.replacingOccurrences(of: "%", with: "")) ?? 0) / 100.0)

       
        
        
        
    }
    

    func getRecipe(name: String, imageData: Data, ingredients:String, calories: String, fatsTotal: String, fatsDaily: String, carbohydratesTotal: String, carbohydratesDaily: String, proteinTotal: String, proteinDaily: String, fiberTotal: String, fiberDaily: String, sugarTotal: String, sugarDaily: String, cholesterolTotal: String, cholesterolDaily: String, sodiumTotal: String, sodiumDaily: String, calciumTotal: String, calciumDaily: String, magnesiumTotal: String, magnesiumDaily: String, potassiumTotal: String, potassiumDaily: String, ironTotal: String, ironDaily: String, zincTotal: String, zincDaily: String, phosphorusTotal: String, phosphorusDaily: String) {
        
        
        navigationItem.title = name
        self.imageData = imageData
        self.ingredients = ingredients
        self.calories = calories
        self.fatsTotal = fatsTotal
        self.fatsDaily = fatsDaily
        self.carbohydratesTotal = carbohydratesTotal
        self.carbohydratesDaily = carbohydratesDaily
        self.proteinTotal = proteinTotal
        self.proteinDaily = proteinDaily
        self.fiberTotal = fiberTotal
        self.fiberDaily = fiberDaily
        self.sugarTotal = sugarTotal
        self.sugarDaily = sugarDaily
        self.cholesterolTotal = cholesterolTotal
        self.cholesterolDaily = cholesterolDaily
        self.sodiumTotal = sodiumTotal
        self.sodiumDaily = sodiumDaily
        self.calciumTotal = calciumTotal
        self.calciumDaily = calciumDaily
        self.magnesiumTotal = magnesiumTotal
        self.magnesiumDaily = magnesiumDaily
        self.potassiumTotal = potassiumTotal
        self.potassiumDaily = potassiumDaily
        self.ironTotal = ironTotal
        self.ironDaily = ironDaily
        self.zincTotal = zincTotal
        self.zincDaily = zincDaily
        self.phosphorusTotal = phosphorusTotal
        self.phosphorusDaily = phosphorusDaily


    }
}
