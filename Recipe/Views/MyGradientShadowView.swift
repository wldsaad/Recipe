//
//  MyGradientShadowView.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class MyGradientShadowView: UIView {

    let gradientLayer = CAGradientLayer()
    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0){
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0, y: 0.0){
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.shadowColor = shadowColor.cgColor
        gradientLayer.shadowOffset = shadowOffset
        gradientLayer.shadowRadius = shadowRadius
        gradientLayer.shadowOpacity = shadowOpacity
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
