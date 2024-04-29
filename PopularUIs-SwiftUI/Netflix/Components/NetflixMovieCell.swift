//
//  NetflixMovieCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 29/04/2024.
//

import SwiftUI

struct NetflixMovieCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    
    var imageName: String = Constants.randomImage
    var title: String? = "Movie title"
    var isRecentlyAdded: Bool = true
    var topTenRanking: Int? = nil
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing: 0) {
                    if let title, let firstWord = title.components(separatedBy: " ").first { // -> display only the first word
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .offset(y:2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0) // we only want to show it when isRecentlyAdded is true
                        
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
        //.background(Color.blue)
    }
}

#Preview {
    ZStack {
        
        Color.black.ignoresSafeArea()
        
        ScrollView {
            VStack {
                NetflixMovieCell(isRecentlyAdded: true)
                NetflixMovieCell(isRecentlyAdded: false)
                NetflixMovieCell(isRecentlyAdded: true, topTenRanking: 10)
                NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 10)
                NetflixMovieCell(isRecentlyAdded: true, topTenRanking: 8)
                NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 2)
            }
        }
    }
}
