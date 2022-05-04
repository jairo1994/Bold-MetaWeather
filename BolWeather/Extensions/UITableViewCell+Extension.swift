//
//  UITableViewCell+Extension.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

extension UITableViewCell{
    func addShadow(background: UIColor = Colors.blackWhite.color, corners: CGFloat = 10){
        let backView = UIView()
        backView.tag = 999999
        backView.isUserInteractionEnabled = false
        backView.backgroundColor = background
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = corners
        self.addSubview(backView)
        backView.addConstraintsToParent(padding: 8, viewReference: self)
        
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.shadowOffset = CGSize(width: 2, height: 1.5)
        backView.layer.shadowRadius = 3
        backView.layer.shadowOpacity = 0.5
        backView.layer.masksToBounds = false
        
        self.sendSubviewToBack(backView)
    }
}
