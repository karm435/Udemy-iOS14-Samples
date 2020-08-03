//
//  LaunchView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI

struct LaunchView: View {
    @State private var selection: String? = nil
    @EnvironmentObject private var model: ChatModel
    
    var body: some View {
            ZStack {
                Background()
                VStack{
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Flash Chat")
                            .foregroundColor(.black)
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                    }
                    .padding()
                    Spacer()
                    VStack{
                        VStack(spacing: 5){
                            NavigationLink(
                                destination:
                                    LoginView(),
                                tag:
                                    "login",
                                selection:
                                    $selection){ EmptyView()}
                            
                            NavigationLink(
                                destination: RegisterView(),
                                tag: "register",
                                selection: $selection){ EmptyView()}
                            
                            
                            Button("Login"){
                                selection = "login"
                            }
                            .foregroundColor(.white)
                            .buttonStyle(BorderedButton(backgroundColor: Color(UIColor.systemTeal)))
                            .accessibility(label: Text("Login"))
                            
                            Button("Register"){
                                selection = "register"
                            }.foregroundColor(.white)
                            .buttonStyle(BorderedButton(backgroundColor: Color(UIColor.systemOrange)))
                            .accessibility(label: Text("Register"))
                        }
                        .padding()
                    }
                }
            }
        
        .navigationBarBackButtonHidden(true)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

struct Background: View {
    var body: some View {
        Rectangle().fill(
            LinearGradient(gradient: Gradient(colors: [.red, Color.white]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}
