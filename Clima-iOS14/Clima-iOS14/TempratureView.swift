//
//  TempratureView.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import SwiftUI

struct TempratureView: View {
    var temprature: Double
    var body: some View {
        HStack(alignment: .top) {
            Text(String(format: "%.f", temprature))
                    .font(.system(size: 100, weight: .bold, design: .rounded))
            Text("℃")
                .font(.system(size: 100, weight: .light, design: .rounded))
        }
        .padding(.trailing)
    }
}

struct TempratureView_Previews: PreviewProvider {
    static var temprature: Double = 21.0
    static var previews: some View {
        TempratureView(temprature: temprature)
    }
}
