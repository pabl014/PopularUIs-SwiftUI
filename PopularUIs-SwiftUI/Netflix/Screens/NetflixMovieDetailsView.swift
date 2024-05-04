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
    @State private var isMyList: Bool = false
    
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
                    VStack(alignment: .leading, spacing: 16) {
                        NetflixDetailsProductView(
                            title: product.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonsCount: 7,
                            hasClosedCaptions: true,
                            isTopTen: 3,
                            descriptionText: product.description,
                            castText: "Robert De Niro, Al Pacino, Mariusz Pudzianowski",
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            }
                        )
                        
                        HStack(spacing: 32) {
                            MyListButton(isMyList: isMyList) {
                                isMyList.toggle()
                            }
                            
                            RateButton { selection in
                                // do something with selection
                                // ( if we want to do something with our database or do something that now that the user clicked love it
                            }
                            
                            ShareButton()
                        }
                        .padding(.leading, 32)
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
