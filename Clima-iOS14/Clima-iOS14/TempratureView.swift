//
//  TempratureView.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import SwiftUI

struct TempratureView: View {
    @Binding var temprature: Int
    var body: some View {
        HStack(alignment: .top) {
            Text(temprature.description)
                    .font(.system(size: 100, weight: .bold, design: .rounded))
            Text("℃")
                .font(.system(size: 100, weight: .light, design: .rounded))
        }
        .padding(.trailing)
    }
}

struct TempratureView_Previews: PreviewProvider {
    @State static var temprature: Int = 21
    static var previews: some View {
        TempratureView(temprature: $temprature)
    }
}
