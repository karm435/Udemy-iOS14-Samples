//
//  ContentView.swift
//  Quizzler-iOS14
//
//  Created by Karmjit Singh on 16/7/20.
//

import SwiftUI

struct ContentView: View {
    @State var question: String = ""
    var body: some View {
        ZStack{
           RoundedRectangle(cornerRadius: 10.0)
                .fill(AppColors.mainColor)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("Background-Bubbles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
             }
            
            QuestionView(question: $question)
        }
        .onAppear {
            self.question = "Tow plus Four equals 6"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

