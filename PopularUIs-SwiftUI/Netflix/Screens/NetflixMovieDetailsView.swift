//
//  NetflixMovieDetailsView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 03/05/2024.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    
    var product: Product = .mockProduct
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
