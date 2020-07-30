//
//  CustomTextFieldStyle.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 40, alignment: .center)
            .padding()
            .lineLimit(1)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white).shadow(radius: 10))
        
    }
    
}
