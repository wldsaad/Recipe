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
    
    private var hits = [HitObject]()
    private var recipes = [Recipe]()
    
    private var searchText = "chicken"
    private var from = 0
    private var to = 6
    private var totalHits = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFoods(withText: searchText, from: from, to: to)
    }

    func getFoods(withText search: String, from: Int, to: Int){
        activityIndicator.startAnimating()
        let url = Constants().getBaseURL(withSearchText: search, from: from, to: to)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let jsonData = data , error == nil else {
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
                    }
                }
            } catch{
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
        return CGSize(width: (collectionView.frame.size.width / 2) - 10, height: 200)
    }
}
