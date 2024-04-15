//
//  SpotifyHomeView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 15/04/2024.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        
        ZStack {
            Color.spotifyBlack
                .ignoresSafeArea()
            
            header
        }
        .task {
            await getData()
        }
    }
    
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
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
    }
}

#Preview {
    SpotifyHomeView()
}
