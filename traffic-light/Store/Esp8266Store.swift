//
//  Esp8266Store.swift
//  traffic-light
//
//  Created by Leonardo Menezes on 27/09/20.
//  Copyright © 2020 Leonardo Menezes. All rights reserved.
//

import Foundation
import Combine


class Esp8266Store: ObservableObject {
    @Published var espModel : ESP8266Model = ESP8266Model.init(message: "T")
    let espProvider = Esp8266ViewModel()
    var cancellable: AnyCancellable?
    
    func toogleLight(resource: String, lightStatusOn: Bool){
        cancellable = espProvider.toogleLight(resource: resource, lightStatusOn: lightStatusOn)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                    break
                case .failure(let error):
                    print("failure")
                    self.espModel.message = error.localizedDescription
                }
            }, receiveValue: { espModel in
                self.espModel = espModel
            })
    }
}


