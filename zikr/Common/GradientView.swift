//
//  GradientView.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import UIKit

class GradientView: UIView {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
    }
    
    func configureGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor,
                                UIColor(red: 93/255,
                                        green: 188/255,
                                        blue: 210/255,
                                        alpha: 0).cgColor]
        layer.addSublayer(gradientLayer)
    }
}
