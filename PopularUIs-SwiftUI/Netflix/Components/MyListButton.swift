//
//  MyListButton.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 04/05/2024.
//

import SwiftUI

struct MyListButton: View {
    
    var isMyList: Bool = false
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(systemName: "checkmark")
                    .opacity(isMyList ? 1 : 0)
                
                Image(systemName: "plus")
                    .opacity(isMyList ? 0 : 1)
            }
            .font(.title)
            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            onButtonPressed?()
        }
    }
}

fileprivate struct MyListButtonPreview: View {
    
    @State private var isMyList = true
    
    var body: some View {
        MyListButton(isMyList: isMyList) {
            isMyList.toggle()
        }
    }
}


#Preview {
    
    ZStack {
        Color.black.ignoresSafeArea()
        
        MyListButtonPreview()
    }
}
