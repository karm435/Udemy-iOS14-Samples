//
//  SearchBar.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI
import os

struct SearchBar: View {
    @State var placeHolder: String = "Search"
    @Binding var searchTerm: String
    var action: () -> Void
    var locationAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: locationAction, label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .padding(.all, 5)
                    .foregroundColor(Color.label)
            })
            .frame(width: 40, height: 40, alignment: .leading)
           
            TextField(placeHolder, text: $searchTerm, onCommit: action)
            .frame(height: 40)
            .padding(.trailing, 10)
            .background(RoundedRectangle(cornerRadius: 5.0, style: .continuous).fill(Color.systemFill))
            .autocapitalization(.words)
            .keyboardType(.webSearch)
            .multilineTextAlignment(.trailing)
            
            Button(action: action, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .padding(.all, 5)
                    .foregroundColor(Color.label)
            })
            .frame(width: 40, height: 40, alignment: .leading)
           
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm = ""
    static var previews: some View {
        Group {
            SearchBar(searchTerm: $searchTerm, action: {}, locationAction: {})
            SearchBar(searchTerm: $searchTerm, action: {}, locationAction: {})
                .preferredColorScheme(.dark)
        }
    }
}
