//
//  ViewController.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class SearchRecipe: UIViewController {

    private var hits = [HitObject]()
    private var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                    
                }
            } catch{
                debugPrint(error.localizedDescription)
            }
        }).resume()
    }

}

