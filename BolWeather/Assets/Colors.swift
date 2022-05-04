//
//  Colors.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation
import UIKit

enum Colors: String{
    case blackWhite = "BlackWhite"
    case topGradient = "TopGradient"
    case bottomGradient = "BottomGradient"
    
    var color: UIColor{
        return UIColor(named: self.rawValue) ?? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) //Pongo el color verde para indicar que el color no ha sido encontrado
    }
    
}
