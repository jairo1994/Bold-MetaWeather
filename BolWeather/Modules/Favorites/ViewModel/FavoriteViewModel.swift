//
//  FavoriteViewModel.swift
//  BolWeather
//
//  Created by Jairo Lopez on 04/05/22.
//

import Foundation

class FavoriteViewModel{
    
    var favorites: [LocationModel]?
    
    func retrieveFavs(){
        let favs = Database().retrieveTasks() ?? nil
        favorites = favs
    }
    
    func numberOfRows()-> Int {
        let count = favorites?.count ?? 0
        return count
    }
    
    func delete(index: Int){
        if let favorites = favorites{
            let title = favorites[index].title
            Database().delete(woeid: favorites[index].woeid)
            Messages.showMessage(theme: .error, title: "Listo", body: "Se elimino a \(title) de sus favoritos")
        }
    }
}

