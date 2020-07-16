//
//  ContentView.swift
//  Quizzler-iOS14
//
//  Created by Karmjit Singh on 16/7/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .fill(AppColors.mainColor)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)
            QuestionView()
        }
    }
}

struct QuestionView: View{
    var body: some View {
        VStack{
            HStack{
                Text("Questionasdfasdfsadfsfd\nText")
                    .foregroundColor(.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            VStack(spacing: 5){
                VStack(spacing: 15){
                    
                    Button(action: {}, label: {
                        Text("True")
                        
                    }) .buttonStyle(BorderedButton())
                    
                    Button(action: {}, label: {
                        Text("False").foregroundColor(.white)
                    }).buttonStyle(BorderedButton())
                }
                .padding(.all)
                
                ProgressView()
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 20, alignment: .leading)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

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
    }
    
}
