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
    
    func isFAvorite()-> Bool{
        return Database().searchLocation(woeid: woeid)
    }
    
    func save(){
        Database().save(woeid: detail.woeid, name: detail.title, kind: detail.location_type, latt_long: detail.latt_long)
        Messages.showMessage(theme: .success, title: "Listo", body: "Se guardo a \(detail.title) en sus favoritos")
    }
    
    func delete(){
        Database().delete(woeid: detail.woeid)
        Messages.showMessage(theme: .error, title: "Listo", body: "Se elimino a \(detail.title) de sus favoritos")
    }
    
}
