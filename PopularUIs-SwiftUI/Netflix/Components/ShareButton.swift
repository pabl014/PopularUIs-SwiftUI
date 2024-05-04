//
//  ShareButton.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 04/05/2024.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://github.com/pabl014"
    
    @ViewBuilder // -> no need to use that in newer versions of Swift
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
