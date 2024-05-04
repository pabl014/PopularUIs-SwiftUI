//
//  NetflixMovieDetailsView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 03/05/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMovieDetailsView: View {
    
    @Environment(\.router) var router
    
    var product: Product = .mockProduct
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    
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
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        detailsProductSection
                        
                        buttonsSection

                        productsGridSection

                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailsView(product: product)
        }
    }
    
    
    private func getData() async {
        
        guard products.isEmpty else { return }
        
        do {
            products = try await DatabaseHelper().getProducts()
            
        } catch {
            
        }
    }
    
    
    private var detailsProductSection: some View {
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
    }
    
    
    private var buttonsSection: some View {
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
    
    
    private var productsGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 8 ), count: 3),
                alignment: .center,
                spacing: 8,
                pinnedViews: [],
                content: {
                    ForEach(products) { product in
                        NetflixMovieCell(
                            imageName: product.firstImage,
                            title: product.title,
                            isRecentlyAdded: product.recentlyAdded,
                            topTenRanking: nil
                        )
                        .onTapGesture {
                            onProductPressed(product: product)
                        }
                    }
            })
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    RouterView { _ in
        NetflixMovieDetailsView()
    }
}
