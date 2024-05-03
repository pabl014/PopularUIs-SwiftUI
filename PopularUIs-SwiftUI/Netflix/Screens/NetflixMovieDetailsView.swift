//
//  NetflixMovieDetailsView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 03/05/2024.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    
    var product: Product = .mockProduct
    @State private var progress: Double = 0.2
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed: {
                        
                    }
                )
                
                ScrollView(.vertical) {
                    
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
