//
//  Esp8266ViewModel.swift
//  traffic-light
//
//  Created by Leonardo Menezes on 29/09/20.
//  Copyright © 2020 Leonardo Menezes. All rights reserved.
//

import Foundation
import Combine


class Esp8266ViewModel : ObservableObject {
    @Published var esp8266Model = ESP8266Model(message : "")
    private let repository = Esp8266Service()
    private var cancellable : AnyCancellable?
    
    
    func toogleLight(resource : Esp8266Resources, isOn: Bool) {
        cancellable = repository.toogleLight(resource: resource, isOn: isOn)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {complete in
                switch complete {
                case .finished:
                    break
                case .failure(let error):
                    self.esp8266Model.message = error.localizedDescription
                }
                
            }) { esp8266Model in
                self.esp8266Model = esp8266Model
            }
    }
}


