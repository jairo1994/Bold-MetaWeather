//
//  DataManager.swift
//  BolWeather
//
//  Created by Jairo Lopez on 04/05/22.
//

import Foundation
import CoreData
import UIKit

class Database{
    
    static var shared: Database{
        let apiRequest = Database()
        return apiRequest
    }
    
    var entity: [NSManagedObject] = []
    
    func save(woeid: Int, name: String, kind: String, latt_long: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext)!
        
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
        
        location.setValue(woeid, forKeyPath: "woeid")
        location.setValue(name, forKeyPath: "name")
        location.setValue(kind, forKeyPath: "kind")
        location.setValue(latt_long, forKey: "latt_long")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveTasks()-> [LocationModel]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        do {
            var favorites = [LocationModel]()
            entity = try managedContext.fetch(fetchRequest)
            
            entity.forEach { object in
                let favorite = LocationModel()
                
                favorite.woeid = object.value(forKeyPath: "woeid") as? Int ?? 0
                favorite.title = object.value(forKeyPath: "name") as? String ?? ""
                favorite.location_type = object.value(forKeyPath: "kind") as? String ?? ""
                favorite.latt_long = object.value(forKeyPath: "latt_long") as? String ?? ""
                
                if favorite.woeid != 0{
                    favorites.append(favorite)
                }
            }
            
            return favorites
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(woeid: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        fetchRequest.predicate = NSPredicate(format: "any woeid == %d", woeid)
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for obj in objects {
                managedContext.delete(obj)
            }
            
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func searchLocation(woeid: Int)-> Bool{
        guard let locations = self.retrieveTasks() else {
            return false
        }
        
        if locations.first(where: ({$0.woeid == woeid})) != nil{
            return true
        }else{
            return false
        }
    }
}
