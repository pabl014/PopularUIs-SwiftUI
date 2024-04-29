//
//  NetflixHomeView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 25/04/2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8) {
                    
                    Rectangle()
                        .opacity(0)
                        //.fill(.orange)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: true,
                            title: heroProduct.title,
                            categories: [heroProduct.category.capitalized, heroProduct.brand],
                            onBackgroundPressed: {
                                
                            },
                            onPlayPressed: {
                                
                            },
                            onMyListPressed: {
                                
                            }
                        )
                        .padding(24)
                    }
                        
                    LazyVStack(spacing: 16) {
                        ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(row.title)
                                    .font(.headline)
                                    .padding(.horizontal, 16)
                                
                                ScrollView(.horizontal) {
                                    LazyHStack {
                                        ForEach(Array(row.products.enumerated()), id: \.offset) { (index , product) in
                                            NetflixMovieCell(
                                                imageName: product.firstImage,
                                                title: product.title,
                                                isRecentlyAdded: product.recentlyAdded,
                                                topTenRanking: rowIndex == 1 ? (index + 1) : nil // we only want to give top10 for the second row
                                            )
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .scrollIndicators(.hidden)
                            }
                        }
                    }
                    
                    ForEach(0..<20) { _ in
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 200)
                    }
                }
            }
            
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter,
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    onXMarkPressed: {
                        selectedFilter = nil
                    }
                )
                .padding(.top, 16)
                
                //Spacer(minLength: 0)
            }
            .background(.blue)
            .readingFrame { frame in // wrapping geometry reader on the background and getting the geometry of the object
                fullHeaderSize = frame.size
            }
            
            
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func getData() async {
        
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            // productRows operations:
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand }) // Set to remove duplicates
            for brand in allBrands {
                // let products = self.products.filter({ $0.brand == brand }) // get all products from current brand
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            
            productRows = rows
            
        } catch {
            // print("Some error occured")
        }
    }
    
    
    private var header: some View {
        
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
}

#Preview {
    NetflixHomeView()
}
