//
//  SearchBar.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 25.09.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search repositories...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchBar(text: $searchText)
}
