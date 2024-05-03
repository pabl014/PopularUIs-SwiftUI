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
    @State private var scrollViewOffset: CGFloat = 0 // tracking vertical scroll
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrollViewLayer
            
            fullHeaderWithFilter
            
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
                rows.append(ProductRow(title: brand.capitalized, products: products.shuffled()))
            }
            
            productRows = rows
            
        } catch {
            // print("Some error occured")
        }
    }
    
    
    private var backgroundGradientLayer: some View {
        
        ZStack {
            LinearGradient(
                colors: [
                    .netflixDarkGray.opacity(1),
                    .netflixDarkGray.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    .netflixDarkRed.opacity(0.5),
                    .netflixDarkRed.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.75)))) // + scrollViewOffset -> it moves with the scrollview, * 0.75 -> moves a lil bit slower
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    
    private var fullHeaderWithFilter: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
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
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            // Material.ultraThin
            // or:
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in // wrapping geometry reader on the background and getting the geometry of the object
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
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
    
    
    private func heroCell(heroProduct: Product) -> some View {
        
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
    
    
    private var scrollViewLayer: some View {
        
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false,
            content: {
                VStack(spacing: 8) {
                    Rectangle()
                        .opacity(0)
                        //.fill(.orange)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(heroProduct: heroProduct)
                    }
                    
                    
                    Text("\(scrollViewOffset)")
                        .foregroundStyle(.red)
                    
                    categoryRows
                }
            },
            onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
                //scrollViewOffset = offset.y
            }
        )
    }
    
    
    private var categoryRows: some View {
        
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
    }
}

#Preview {
    NetflixHomeView()
}
