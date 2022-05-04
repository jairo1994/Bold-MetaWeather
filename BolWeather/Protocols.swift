//
//  Protocols.swift
//  BolWeather
//
//  Created by Jairo Lopez on 04/05/22.
//

import Foundation



protocol OpenSourceProtocol {
    func openSource(link: String)-> Void
}

protocol SaveDatabaseProtocol {
    func save(woeid: Int, name: String, kind: String)
}

protocol RetrieveOrDeleteProtocol{
    func retrieve()-> [LocationModel]
    func delete(woeid: Int)
}
