//
//  FavoriteRecipe.swift
//  Recipe
//
//  Created by Waleed Saad on 1/14/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteRecipeVC: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noRecipesLabel: UILabel!
    
    private var recipes: Results<RecipeObject>?
    private var isSearchOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipesFromRealm()

    }
    
    private func showHideViews(){
        if recipes?.count == 0 {
            noRecipesLabel.isHidden = false
        } else {
            noRecipesLabel.isHidden = true
        }
    }
    private func getRecipesFromRealm(){
        recipes = realm.objects(RecipeObject.self)
        collectionView.reloadData()
        showHideViews()
    }
    

}
extension FavoriteRecipeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? RecipeCell {
            cell.updateViewFavorite(recipe: recipes?[indexPath.row] ?? RecipeObject())
            return cell
        }
        return RecipeCell()
    }
}

extension FavoriteRecipeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 2) - 10, height: Constants.cellHeight)
    }
}

extension FavoriteRecipeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipe = recipes?[indexPath.row]{
            performSegue(withIdentifier: "recipeSegueFromFav", sender: recipe)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeVC = segue.destination as? RecipeVC {
            if let recipe = sender as? RecipeObject {
                let imageData = recipe.imageData
                let name = recipe.name
                let calories = recipe.calories
                let ingredients = recipe.ingredients
                let fatsTotal = recipe.fatsTotal
                let fatsDaily = recipe.fatsDaily
                let carbohydratesTotal = recipe.carbohydratesTotal
                let carbohydratesDaily = recipe.carbohydratesDaily
                let proteinTotal = recipe.proteinTotal
                let proteinDaily = recipe.proteinDaily
                let fiberTotal = recipe.fiberTotal
                let fiberDaily = recipe.fiberDaily
                let sugarTotal = recipe.sugarTotal
                let sugarDaily = recipe.sugarDaily
                let cholesterolTotal = recipe.cholesterolTotal
                let cholesterolDaily = recipe.cholesterolDaily
                let sodiumTotal = recipe.sodiumTotal
                let sodiumDaily = recipe.sodiumDaily
                let calciumTotal = recipe.calciumTotal
                let calciumDaily = recipe.calciumDaily
                let magnesiumTotal = recipe.magnesiumTotal
                let magnesiumDaily = recipe.magnesiumDaily
                let potassiumTotal = recipe.potassiumTotal
                let potassiumDaily = recipe.potassiumDaily
                let ironTotal = recipe.ironTotal
                let ironDaily = recipe.ironDaily
                let zincTotal = recipe.zincTotal
                let zincDaily = recipe.zincDaily
                let phosphorusTotal = recipe.phosphorusTotal
                let phosphorusDaily = recipe.phosphorusDaily
                let shareAs = recipe.id
                
                
                recipeVC.getRecipe(name: name, imageData: imageData, ingredients: ingredients, calories: calories, fatsTotal: fatsTotal, fatsDaily: fatsDaily, carbohydratesTotal: carbohydratesTotal, carbohydratesDaily: carbohydratesDaily, proteinTotal: proteinTotal, proteinDaily: proteinDaily, fiberTotal: fiberTotal, fiberDaily: fiberDaily, sugarTotal: sugarTotal, sugarDaily: sugarDaily, cholesterolTotal: cholesterolTotal, cholesterolDaily: cholesterolDaily, sodiumTotal: sodiumTotal, sodiumDaily: sodiumDaily, calciumTotal: calciumTotal, calciumDaily: calciumDaily, magnesiumTotal: magnesiumTotal, magnesiumDaily: magnesiumDaily, potassiumTotal: potassiumTotal, potassiumDaily: potassiumDaily, ironTotal: ironTotal, ironDaily: ironDaily, zincTotal: zincTotal, zincDaily: zincDaily, phosphorusTotal: phosphorusTotal, phosphorusDaily: phosphorusDaily, shareAs: shareAs)
                
            }
        }
    }

}

extension FavoriteRecipeVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchOpen = true
        addCloseSearchBar()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchedRecipesFromRealm()
    }
    
    private func getSearchedRecipesFromRealm(){
        if let searchedRecipe = searchBar.text {
            if searchedRecipe.count > 0 {
                recipes = realm.objects(RecipeObject.self).filter("name CONTAINS[cd] %@", searchedRecipe)
                self.collectionView.reloadData()
            } else {
                getRecipesFromRealm()
            }
        }
    }
}
