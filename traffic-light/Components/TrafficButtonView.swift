//
//  TrafficButtonView.swift
//  traffic-light
//
//  Created by Leonardo Menezes on 25/09/20.
//  Copyright © 2020 Leonardo Menezes. All rights reserved.
//

import SwiftUI

struct TrafficButtonView: View {
    
    @Binding var isLightOn : Bool
    @State var lightColor : UIColor
    
    
    var body: some View {
        
        let ligthColorOff = Color(lightColor.withAlphaComponent(0.1))
        let ligthColorOn = Color(lightColor)
        
        Circle()
            .fill(self.isLightOn ? ligthColorOff : ligthColorOn)
            .frame(width: 150, height: 150, alignment: .center)
            .padding()
    }
}


struct TrafficButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TrafficButtonView(isLightOn: .constant(true), lightColor: .red)
    }
}
