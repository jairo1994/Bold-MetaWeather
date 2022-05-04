//
//  DayInfoTableViewCell.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit
import Kingfisher

class DayInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var dayWNumber: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(info: Consolidated_weather){
        
        let url = URL(string: "\(LookForService().imageURl)\(info.weather_state_abbr).png")

        icon.kf.setImage(with: url)
        day.text = Date(fromString: info.applicable_date, format: .isoDate)?.toString(style: .weekday)
        dayWNumber.text = Date(fromString: info.applicable_date, format: .isoDate)?.toString(format: .custom("MMM d"))
        min.text = "\(info.min_temp.toInt() ?? 0)° C"
        max.text = "\(info.max_temp.toInt() ?? 0)° C"
        
    }
    
}


extension Double {

    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }

}
