//
//  SpotifyPlaylistView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 17/04/2024.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    let product: Product = .mockProduct
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        title: product.title,
                        subtitle: product.brand,
                        imageName: product.thumbnail,
                        height: 250
                    )
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
