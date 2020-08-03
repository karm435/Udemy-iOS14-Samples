//
//  CustomTextFieldStyle.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    private var maxHeight: CGFloat
    init(maxHeight: CGFloat = 30) {
        self.maxHeight = maxHeight
    }
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: maxHeight, alignment: .center)
            .padding()
            .lineLimit(1)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white).shadow(radius: 10))
        
    }
    
}

struct CustomTextFieldStyle_Previews: PreviewProvider {
    @State private static var text: String = ""
    static var previews: some View {
        Group {
            TextField("message", text: $text)
                .textFieldStyle(CustomTextFieldStyle(maxHeight: 20))
            TextField("message", text: $text)
                .preferredColorScheme(.dark)
                .textFieldStyle(CustomTextFieldStyle(maxHeight: 20))
        }
    }
}
