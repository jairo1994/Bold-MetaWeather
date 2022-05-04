//
//  LookForService.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation
import Alamofire

class LookForService{
    
    private var baseUrl = "https://www.metaweather.com/api/location/"
    var imageURl = "https://www.metaweather.com/static/img/weather/png/64/"
    
    let header: HTTPHeaders = HTTPHeaders()
    
    static var shared: LookForService{
        let apiService = LookForService()
        return apiService
    }
    
    func lookForRequest(lookFor: String, Callback: @escaping(_ locations: [LocationModel]?)->Void){
        let url = "\(baseUrl)search"
        
        RequestService.shared.getFrom(url: url, parameters: ["query": lookFor as AnyObject], timeOutInterval: 20, headers: header, type: [LocationModel].self) { (data, error) in
            if error == nil, let objc = data as? [LocationModel]{
                Callback(objc)
            }else{
                Callback(nil)
            }
        }
    }
    
    func detailRequest(woeid: Int, Callback: @escaping(_ detail: DetailModel?)->Void){
        let url = "\(baseUrl)location/\(woeid)"
        
        RequestService.shared.getFrom(url: url, parameters: nil, timeOutInterval: 20, headers: header, type: DetailModel.self) { (data, error) in
            if error == nil, let objc = data as? DetailModel{
                Callback(objc)
            }else{
                Callback(nil)
            }
        }
    }
    
}
