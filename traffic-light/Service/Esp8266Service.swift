//
//  Esp8266Repository.swift
//  traffic-light
//
//  Created by Leonardo Menezes on 29/09/20.
//  Copyright © 2020 Leonardo Menezes. All rights reserved.
//

import Foundation
import Combine


enum Esp8266Resources : String {
    case GREEN = "green"
    case YELLOW = "yellow"
    case RED = "red"
}


class Esp8266Service {
    
    private let BASE_URL = "http://192.168.0.21/lights"
    private let sessionConfig = URLSessionConfiguration.default
    private let session : URLSession
    
    
    init() {
        self.sessionConfig.timeoutIntervalForResource = 2.5
        self.sessionConfig.timeoutIntervalForRequest = 2.5
        self.session = URLSession(configuration: sessionConfig)
    }
    
    
    func toogleLight(resource: Esp8266Resources, isOn : Bool) -> AnyPublisher <ESP8266Model, Error> {
        var requestUrl = URLComponents( string: self.BASE_URL)
        let requestValue = isOn ? 1 : 0
        
        requestUrl?.queryItems = [
            URLQueryItem(name: resource.rawValue, value: String(requestValue))
        ]
        
        let request = URLRequest(url: (requestUrl?.url!)!)
        
        return session.dataTaskPublisher(for: request)
            .map{ $0.data}
            .decode(type: ESP8266Model.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
