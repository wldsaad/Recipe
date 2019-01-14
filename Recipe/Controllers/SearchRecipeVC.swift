//
//  ViewController.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class SearchRecipeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var enterRecipeLabel: UILabel!
    
    private var hits = [HitObject]()
    private var recipes = [Recipe]()
    
    private var searchText = ""
    private var from = 0
    private var to = 6
    private var totalHits = 0
    private var isSearchOpen = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showHideViews()
    }

    private func showHideViews(){
        if recipes.count == 0 {
            backButton.isHidden = true
            nextButton.isHidden = true
            enterRecipeLabel.isHidden = false
        } else {
            backButton.isHidden = false
            nextButton.isHidden = false
            enterRecipeLabel.isHidden = true
        }
    }
    
    func getFoods(withText search: String, from: Int, to: Int){
        activityIndicator.startAnimating()
        enterRecipeLabel.isHidden = true
        let url = Constants().getBaseURL(withSearchText: search, from: from, to: to)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let jsonData = data , error == nil else {
                self.activityIndicator.stopAnimating()
                self.enterRecipeLabel.isHidden = false
                return
            }
            do {
                let json = try JSONDecoder().decode(JsonModel.self, from: jsonData)
                self.totalHits = json.count ?? 0
                if let hits = json.hits {
                    self.hits.removeAll()
                    self.recipes.removeAll()
                    for (index, hit) in hits.enumerated() {
                        self.hits.append(hit)
                        if let recipe = hits[index].recipe {
                            self.recipes.append(recipe)
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.showHideViews()
                    }
                } else {
                    self.activityIndicator.stopAnimating()
                    self.enterRecipeLabel.isHidden = false
                }
            } catch{
                self.activityIndicator.stopAnimating()
                self.enterRecipeLabel.isHidden = false
                debugPrint(error.localizedDescription)
            }
        }).resume()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        if to > (totalHits - 6){
            return
        }
        from += 6
        to += 6
        getFoods(withText: searchText, from: from, to: to)
    }
    @IBAction func backAction(_ sender: Any) {
        if from < 6 {
            return
        }
        from -= 6
        to -= 6
        getFoods(withText: searchText, from: from, to: to)
    }
}

extension SearchRecipeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? RecipeCell {
            cell.updateView(recipe: self.recipes[indexPath.row])
            return cell
        }
        return RecipeCell()
    }
}

extension SearchRecipeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2) - 10, height: Constants.cellHeight)
    }
}

extension SearchRecipeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "recipeSegue", sender: recipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeVC = segue.destination as? RecipeVC {
            if let recipe = sender as? Recipe {
                var imageData = Data()
                if let imageLink = recipe.image {
                    if let imageURL = URL(string: imageLink) {
                        imageData = try! Data(contentsOf: imageURL)
                    }
                }
                let name = recipe.label
                var calories = ""
                if let caloriesDouble = recipe.calories {
                    calories = String(format: "%.f", caloriesDouble)
                }
                var ingredients = ""
                if let ingredientsLines = recipe.ingredientLines {
                    ingredients = ingredientsLines.joined(separator: "\n")
                }
                
                let fatsTotal = "\(String(format: "%.f", recipe.totalNutrients?.FAT?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let fatsDaily = "\(String(format: "%.f", recipe.totalDaily?.FAT?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let carbohydratesTotal = "\(String(format: "%.f", recipe.totalNutrients?.CHOCDF?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let carbohydratesDaily = "\(String(format: "%.f", recipe.totalDaily?.CHOCDF?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let proteinTotal = "\(String(format: "%.f", recipe.totalNutrients?.PROCNT?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let proteinDaily = "\(String(format: "%.f", recipe.totalDaily?.PROCNT?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let fiberTotal = "\(String(format: "%.f", recipe.totalNutrients?.FIBTG?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let fiberDaily = "\(String(format: "%.f", recipe.totalDaily?.FIBTG?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let sugarTotal = "\(String(format: "%.f", recipe.totalNutrients?.SUGAR?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let sugarDaily = "\(String(format: "%.f", recipe.totalDaily?.SUGAR?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let cholesterolTotal = "\(String(format: "%.f", recipe.totalNutrients?.CHOLE?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let cholesterolDaily = "\(String(format: "%.f", recipe.totalDaily?.CHOLE?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let sodiumTotal = "\(String(format: "%.f", recipe.totalNutrients?.NA?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let sodiumDaily = "\(String(format: "%.f", recipe.totalDaily?.NA?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let calciumTotal = "\(String(format: "%.f", recipe.totalNutrients?.CA?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let calciumDaily = "\(String(format: "%.f", recipe.totalDaily?.CA?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let magnesiumTotal = "\(String(format: "%.f", recipe.totalNutrients?.MG?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let magnesiumDaily = "\(String(format: "%.f", recipe.totalDaily?.MG?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let potassiumTotal = "\(String(format: "%.f", recipe.totalNutrients?.K?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let potassiumDaily = "\(String(format: "%.f", recipe.totalDaily?.K?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let ironTotal = "\(String(format: "%.f", recipe.totalNutrients?.FE?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let ironDaily = "\(String(format: "%.f", recipe.totalDaily?.FE?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let zincTotal = "\(String(format: "%.f", recipe.totalNutrients?.ZN?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let zincDaily = "\(String(format: "%.f", recipe.totalDaily?.ZN?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                let phosphorusTotal = "\(String(format: "%.f", recipe.totalNutrients?.P?.quantity ?? 0.0)) \(recipe.totalNutrients?.FAT?.unit ?? "")"
                let phosphorusDaily = "\(String(format: "%.f", recipe.totalDaily?.P?.quantity ?? 0.0))\(recipe.totalDaily?.FAT?.unit ?? "")"
                var shareAs = ""
                if let shareLink = recipe.shareAs {
                    shareAs = shareLink
                }
                
                
                recipeVC.getRecipe(name: name!, imageData: imageData, ingredients: ingredients, calories: calories, fatsTotal: fatsTotal, fatsDaily: fatsDaily, carbohydratesTotal: carbohydratesTotal, carbohydratesDaily: carbohydratesDaily, proteinTotal: proteinTotal, proteinDaily: proteinDaily, fiberTotal: fiberTotal, fiberDaily: fiberDaily, sugarTotal: sugarTotal, sugarDaily: sugarDaily, cholesterolTotal: cholesterolTotal, cholesterolDaily: cholesterolDaily, sodiumTotal: sodiumTotal, sodiumDaily: sodiumDaily, calciumTotal: calciumTotal, calciumDaily: calciumDaily, magnesiumTotal: magnesiumTotal, magnesiumDaily: magnesiumDaily, potassiumTotal: potassiumTotal, potassiumDaily: potassiumDaily, ironTotal: ironTotal, ironDaily: ironDaily, zincTotal: zincTotal, zincDaily: zincDaily, phosphorusTotal: phosphorusTotal, phosphorusDaily: phosphorusDaily, shareAs: shareAs)

            }
        }
    }
}

extension SearchRecipeVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchOpen = true
        if isSearchOpen {
            addCloseSearchBar()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.searchText = searchText
            from = 0
            to = 6
            getFoods(withText: searchText, from: from, to: to)
            closeSearch()
            
        }
    }
    
    private func addCloseSearchBar() {
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeSearch))
        view.addGestureRecognizer(closeTap)
    }
    @objc private func closeSearch(){
        if isSearchOpen {
            searchBar.resignFirstResponder()
            view.gestureRecognizers?.removeAll()
            isSearchOpen = false
        }
    }
}
