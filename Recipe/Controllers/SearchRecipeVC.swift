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
    
    private var hits = [HitObject]()
    private var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFoods(withText: "chicken")
    }

    func getFoods(withText search: String){
        let url = Constants().getBaseURL(withSearchText: search)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let jsonData = data , error == nil else {
                return
            }
            do {
                let json = try JSONDecoder().decode(JsonModel.self, from: jsonData)
                if let hits = json.hits {
                    for (index, hit) in hits.enumerated() {
                        self.hits.append(hit)
                        if let recipe = hits[index].recipe {
                            self.recipes.append(recipe)
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            } catch{
                debugPrint(error.localizedDescription)
            }
        }).resume()
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
