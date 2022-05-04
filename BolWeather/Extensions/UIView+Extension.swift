//
//  UIView+Extensions.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

extension UIView{
    //MARK: .- For set Constraints to parent
    func addConstraintsToParent(padding: CGFloat = 0, viewReference: UIView) {
        self.leadingAnchor.constraint(equalTo: viewReference.leadingAnchor, constant: padding).isActive = true
        self.topAnchor.constraint(equalTo: viewReference.topAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: viewReference.trailingAnchor, constant: -padding).isActive = true
        self.bottomAnchor.constraint(equalTo: viewReference.bottomAnchor, constant: -padding).isActive = true
    }
    
    func centerOn(_ viewReference: UIView){
        self.centerYAnchor.constraint(equalTo: viewReference.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: viewReference.centerXAnchor).isActive = true
    }
    
}
