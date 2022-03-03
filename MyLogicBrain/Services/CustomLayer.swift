//
//  CustomLayer.swift
//  MyLogicBrain
//
//  Created by Михаил Кожанов on 09.03.2021.
//

import UIKit

struct CustomLayer {
    
    static func addVerticalGradient(from bounds: CGRect,
                                    with grad: (CAGradientLayer) -> Void) {
        let toColor = UIColor(
            red: 218/255,
            green: 233/255,
            blue: 243/255,
            alpha: 1
        )
        
        let fromColor = UIColor(
            red: 125/255,
            green: 179/255,
            blue: 196/255,
            alpha: 1
        )
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [toColor.cgColor, fromColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        grad(gradient)
    }
    
    static func customBackground(layer: UIView) {
        layer.backgroundColor = UIColor (
            red: 168/255,
            green: 213/255,
            blue: 231/255,
            alpha: 1
        )
    }
    
    static func customButton(buttons: [UIButton]) {
        for button in buttons {
            button.frame = CGRect(x:50, y:500, width:180, height:40)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
            button.layer.cornerRadius = 8.0
            button.layer.shadowRadius =  4.0
            button.layer.shadowColor =  UIColor.white.cgColor
            button.layer.shadowOpacity =  0.5
        }
    }
    
    static func customButtonTwo(buttons: [UIButton]) {
        for button in buttons {
            //button.frame = CGRect(x:50, y:500, width:180, height:40)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
            button.layer.cornerRadius = 8.0
            button.layer.shadowRadius =  4.0
            button.layer.shadowColor =  UIColor.white.cgColor
            button.layer.shadowOpacity =  0.5
        }
    }
    
    static func customView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        view.layer.shadowRadius =  4.0
        view.layer.shadowColor =  UIColor.white.cgColor
        view.layer.shadowOpacity =  0.7
    }
    
    static func customLabel(label: UIView) {
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        label.layer.shadowRadius =  3
        label.layer.shadowColor =  UIColor.white.cgColor
        label.layer.shadowOpacity =  0.4
    }
    
    static func customStackView(view: UIStackView) {
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        view.layer.shadowRadius =  0.1
        view.layer.shadowColor =  UIColor.white.cgColor
        view.layer.shadowOpacity =  0.1
    }
}
