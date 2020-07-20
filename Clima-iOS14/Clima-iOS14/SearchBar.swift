//
//  SearchBar.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI

struct SearchBar: View {
    @State var searchTerm: String = ""
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .padding(.all, 5)
                    .foregroundColor(Color.label)
            })
            .frame(width: 40, height: 40, alignment: .leading)
                
            TextField("Search", text: $searchTerm)
                .frame(height: 40, alignment: .trailing)
                .padding(.leading, 10)
                .background(RoundedRectangle(cornerRadius: 5.0, style: .continuous).fill(Color.systemFill))
                
            Button(action: {}, label: {
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
    
    static var previews: some View {
        Group {
            SearchBar(searchTerm: "")
            SearchBar(searchTerm: "")
                .preferredColorScheme(.dark)
        }
    }
}
