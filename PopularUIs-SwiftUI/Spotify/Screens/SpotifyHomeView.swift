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
            HStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite) // in case an image has some transparency
                        .clipShape(Circle())
                        .onTapGesture {
                            // go to the profile screen
                        }
                }
                
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
                }
                .scrollIndicators(.hidden)
            }
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
}

#Preview {
    SpotifyHomeView()
}
