//
//  ImageTitleRowCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 17/04/2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some text blah blah blah blah"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
        //.background(.red)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView(.horizontal) {
            HStack {
                ImageTitleRowCell()
                ImageTitleRowCell()
                ImageTitleRowCell()
                ImageTitleRowCell()
            }
            
            
        }
        
    }
}
