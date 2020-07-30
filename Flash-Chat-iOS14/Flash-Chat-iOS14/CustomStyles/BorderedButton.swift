//
//  BorderedButton.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import Foundation
import SwiftUI

struct AppColors {
    static var mainColor: Color {
        Color.blue
    }
    
    static var secondaryColor: Color {
        Color.blue
    }
}

struct BorderedButton: ButtonStyle {
    private let backgroundColor: Color
    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 40, alignment: .center)
            .padding(.all, 10)
            .background(RoundedRectangle(cornerRadius: 10.00, style: .continuous).stroke(lineWidth: 2.0).fill(self.backgroundColor))
            .background(RoundedRectangle(cornerRadius: 10).fill(self.backgroundColor))
            .opacity(configuration.isPressed ? 0.4 : 1)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

struct BorderedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Button")
            }).buttonStyle(BorderedButton(backgroundColor: Color(UIColor.systemTeal)))
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Button")
            }).buttonStyle(BorderedButton(backgroundColor: Color(UIColor.systemOrange)))
        }
    }
}
