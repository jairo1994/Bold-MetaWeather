//
//  TopInfoView.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation
import UIKit
import Kingfisher

class TopInfoView: UIView{
    
    @IBOutlet weak var weatherState: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var timeZone: UILabel!
    @IBOutlet weak var humedad: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var airPresion: UILabel!
    private let nibName = "TopInfoView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func configView(detail: DetailModel, selectedDay: Int = 0){
        self.timeZone.text = "Zona horaria: \(detail.timezone_name)/\(detail.parent.title)"
        
        if detail.consolidated_weather.indices.contains(selectedDay){
            
            let firstDay = detail.consolidated_weather[selectedDay]
            
            let url = URL(string: "\(LookForService().imageURl)\(firstDay.weather_state_abbr).png")

            weatherState.kf.setImage(with: url)
            
            self.currentTemp.text = "\(firstDay.the_temp.toInt() ?? 0)° C"
            self.humedad.text = "Humedad: \(firstDay.humidity)%"
            self.visibility.text = "Visibilidad: \(firstDay.visibility.toInt() ?? 0) mi "
            self.percent.text = "Probabilidad: \(firstDay.predictability)%"
            self.airPresion.text = "Presion: \(firstDay.air_pressure) mbar"
        }
        
    }
    
}
