//
//  NetflixDetailsProductView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 03/05/2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsProductView: View {
    
    var title: String = "Movie title"
    
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonsCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "Adaptacja opowiadania Josepha Conrada 'Jądro ciemności'. Przeniesiona w realia wojny wietnamskiej historia kapitana Willarda, który otrzymuje misję odnalezienia i zlikwidowania pułkownika Kurtza."
    var castText: String? = "Cast: Szwagier, Antek, Tusk, Kaczynski"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonsCount {
                    Text("\(seasonsCount) Seasons")
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            if let isTopTen {
                HStack(spacing: 8) {
                    topTenIcon
                    
                    Text("#\(isTopTen) in TV Shows Today")
                }
            }
            
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixDarkGray)
                .background(.netflixWhite)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .asButton(.press) {
                    onPlayPressed?()
                }
                
                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.netflixWhite)
    }
    
    
    private var topTenIcon: some View {
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay(
                VStack(spacing: -4) {
                    Text("TOP")
                        .fontWeight(.bold)
                        .font(.system(size: 8))
                    Text("10")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                    .offset(y: 1)
            )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView(.vertical) {
            VStack(spacing: 70) {
                
                NetflixDetailsProductView()
                
                NetflixDetailsProductView(
                    isNew: false,
                    yearReleased: nil,
                    seasonsCount: nil,
                    hasClosedCaptions: false,
                    isTopTen: nil,
                    descriptionText: nil,
                    castText: nil
                )
            }
        }
    }
}
