//
//  RateButton.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 04/05/2024.
//

import SwiftUI

// HOW TO USE POPOVER IN SWIFTUI? :
// https://www.youtube.com/watch?v=bW7N8ACCc6A

enum RateOption: String, CaseIterable { // CaseIterable -> we can loop on them
    case like, dislike, love
    
    var title: String {
        switch self {
        case .like:
            return "I like this"
        case .dislike:
            return "Not for me"
        case .love:
            return "Love this!"
        }
    }
    
    var iconName: String {
        switch self {
        case .like:
            return "hand.thumbsup"
        case .dislike:
            return "hand.thumbsdown"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    
    @State private var showPopover: Bool = false
    var onRatingSelected: ((RateOption) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.thumbsup")
                .font(.title)

            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover, content: {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()
                
                HStack(spacing: 12) {
                    ForEach(RateOption.allCases, id: \.self) { option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
        })
    }
    
    private func rateButton(option: RateOption) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopover = false
            onRatingSelected?(option)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        RateButton()
    }
}
