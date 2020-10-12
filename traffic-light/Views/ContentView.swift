//
//  ContentView.swift
//  traffic-light
//
//  Created by Leonardo Menezes on 12/09/20.
//  Copyright © 2020 Leonardo Menezes. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var esp8266ViewModel = Esp8266ViewModel()
    @State private var showAlert : Bool = false
    @State private var showProgress : Bool = false
    @State private var greenLightStatus = false
    @State private var redLightStatus = false
    @State private var yellowLightStatus = false
    
    
    var body: some View {
        
        VStack{
            
            TrafficButtonView(isLightOn: $greenLightStatus,  lightColor: UIColor.green)
                .onTapGesture(perform:  {
                    esp8266ViewModel.toogleLight(resource: .GREEN, isOn: greenLightStatus)
                    showProgress = true
                    greenLightStatus.toggle()
                })
            
            
            TrafficButtonView(isLightOn: $yellowLightStatus,  lightColor: UIColor.yellow)
                .onTapGesture(perform:  {
                    esp8266ViewModel.toogleLight(resource: .YELLOW, isOn: yellowLightStatus)
                    showProgress = true
                    yellowLightStatus.toggle()
                })
            
            
            TrafficButtonView(isLightOn: $redLightStatus,  lightColor: UIColor.red)
                .onTapGesture(perform:  {
                    esp8266ViewModel.toogleLight(resource: .RED, isOn: redLightStatus)
                    showProgress = true
                    redLightStatus.toggle()
                })
            
        }.onReceive(esp8266ViewModel.$esp8266Model, perform: { espModel in
            if !espModel.message.isEmpty{
                showProgress = false
            }
        }).alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Message"), message: Text(esp8266ViewModel.esp8266Model.message), dismissButton: .cancel())
        }.sheet(isPresented: $showProgress, onDismiss:{
            if esp8266ViewModel.esp8266Model.message != "Success."{
                showAlert = true
            }
        } , content: {
            ProgressView("Waiting ESP8266 response...")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
