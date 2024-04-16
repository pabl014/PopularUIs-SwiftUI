//
//  SpotifyRecentsCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 16/04/2024.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    
    var imageName: String = Constants.randomImage
    var title: String = "Cell name cell name"
    
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
                .foregroundStyle(.red)
                .background(.green)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.trailing, 8) // to not let the text go too close to the right edge
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    }
}
