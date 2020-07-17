//
//  Controls.swift
//  Quizzler-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import Foundation
import SwiftUI

// TODO: - Move to the package
struct BorderedButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 40, alignment: .center)
            .padding(.all, 10)
            .background(RoundedRectangle(cornerRadius: 10.00, style: .continuous).stroke(lineWidth: 2.0).fill(AppColors.secondaryColor))
            .background(RoundedRectangle(cornerRadius: 10).fill(AppColors.mainColor))
            .opacity(configuration.isPressed ? 0.4 : 1)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}
