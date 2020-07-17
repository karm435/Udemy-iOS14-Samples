//
//  QuestionView.swift
//  Quizzler-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI

struct QuestionView: View{
    @Binding var question: String
    var body: some View {
        VStack{
            HStack{
                Text(question)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
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

struct QuestionView_Previews: PreviewProvider {
    @State static var question: String = ""
    static var previews: some View {
        QuestionView(question: $question)
    }
}
