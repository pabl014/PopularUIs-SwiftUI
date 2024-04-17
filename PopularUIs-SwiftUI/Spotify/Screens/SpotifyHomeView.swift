//
//  SpotifyHomeView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 15/04/2024.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        
        ZStack {
            Color.spotifyBlack
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 10,
                           pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack(spacing: 16) {
                            
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            ForEach(productRows) { row in
                                VStack(spacing: 8) {
                                    Text(row.title)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.spotifyWhite)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 16)
                                    
                                    ScrollView(.horizontal) {
                                        HStack(alignment: .top,spacing: 16) {
                                            ForEach(row.products) { product in
                                                ImageTitleRowCell(imageSize: 120, imageName: product.firstImage, title: product.title)
                                            }
                                        }
                                        .background(.blue)
                                        .padding(.horizontal, 16)
                                    }
                                    .scrollIndicators(.hidden)
                                    .background(.red)
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        //.padding(.horizontal, 16)
                        //.background(.blue)
                        
                    } header: {
                        header
                    }

                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
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
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite) // in case an image has some transparency
                        .clipShape(Circle())
                        .onTapGesture {
                            // go to the profile screen
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }
    
    
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.firstImage,
                                   title: product.title)
            }
        }
    }
    
    // func not var, because here a product must be passed in
    private func newReleaseSection(product: Product) -> some View {
        
        SpotifyNewReleaseView(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                
            }
        )
    }
}

#Preview {
    SpotifyHomeView()
}
