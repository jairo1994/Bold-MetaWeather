//
//  DetailViewModel.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation

class DetailViewModel{
    var woeid: Int
    var detail = DetailModel()
    
    var didFetchLocation: ((Bool) -> Void)?
    
    init(_ woeid: Int){
        self.woeid = woeid
    }
    
    func fetchDetailInfo(){
        LookForService().detailRequest(woeid: self.woeid) { detail in
            if let detail = detail {
                self.detail = detail
                self.didFetchLocation?(true)
            }else{
                self.didFetchLocation?(false)
            }
        }
    }
}
