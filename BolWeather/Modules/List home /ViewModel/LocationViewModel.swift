//
//  LocationViewModel.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation

class LocationViewModel{
    
    var didFetchLocation: ((Bool) -> Void)?
    var locations = [LocationModel]()
    
    func lookFor(_ by: String) {
        didFetchLocation?(false)
        LookForService().lookForRequest(lookFor: by) { locationsSearched in
            if let locationsSearched = locationsSearched {
                self.locations = locationsSearched
                self.didFetchLocation?(true)
            }else{
                self.didFetchLocation?(false)
                self.locations = [LocationModel]()
            }
        }
    }
    
    func numberOfRows()-> Int {
        return locations.count
    }
    
    func getInfoByIndex(index: Int)-> LocationModel?{
        if locations.indices.contains(index){
            return locations[index]
        }else{
            return nil
        }
    }
}
