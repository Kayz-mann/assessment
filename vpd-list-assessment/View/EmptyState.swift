//
//  EmptyState.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 25.09.2024.
//

import SwiftUI

struct EmptyState: View {
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            Text("Error: \(message)")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    EmptyState(message: "No data found")
}
