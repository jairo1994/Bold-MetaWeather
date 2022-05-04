//
//  LocationTableViewCell.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var kind: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configViewBy(_ location: LocationModel, searchBarText: String?){
        kind.text = location.location_type
        distance.text = "" //location.latt_long
        
        if let text = searchBarText{
            let attributedWithTextColor: NSAttributedString = location.title.lowercased().attributedStringWithColor([text.lowercased()], color: UIColor.blue)
            self.name.attributedText = attributedWithTextColor
        }
    }
    
}

extension String {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self.firstUppercased)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {
            return attributedString
        }
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}
