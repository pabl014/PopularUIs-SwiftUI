//
//  SpotifyCategoryCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 15/04/2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "All")
            SpotifyCategoryCell(title: "Music")
            SpotifyCategoryCell(title: "Artists", isSelected: true)
            SpotifyCategoryCell(title: "Longlonglong tiltle")
        }
        
    }
}

