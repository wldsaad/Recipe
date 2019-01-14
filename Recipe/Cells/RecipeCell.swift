//
//  RecipeCell.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    
    private var myXibView: RecipeXibView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instantiateXibView()
    }
    
    private func instantiateXibView(){
        myXibView = Bundle.main.loadNibNamed("RecipeXib", owner: self, options: nil)?.first as? RecipeXibView
        myXibView.frame = self.frame
        self.addSubview(myXibView)
    }

    func updateView(recipe: Recipe){
        
        myXibView.recipeLabel.text = recipe.label
        guard let imageLink = recipe.image else {
            return
        }
        if let imageURL = URL(string: imageLink) {
            do {
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    self.myXibView.recipeImageView.image = UIImage(data: imageData)
                }
            } catch {
                
            }
            
            
        }
    }
    
    func updateViewFavorite(recipe: RecipeObject){
        
        myXibView.recipeLabel.text = recipe.name
        DispatchQueue.main.async {
            self.myXibView.recipeImageView.image = UIImage(data: recipe.imageData)
        }
    }

    
    
}
