//
//  BumbleProfileImageCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 24/04/2024.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    
    var body: some View {
        ZStack {
            
            
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: percentageRemaining )
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90)) // start from he bottom and go clockwise
                .scaleEffect(x: -1, y: 1, anchor: .center) // this line enables counter-clockwise
            
            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(5)
                
        }
        .frame(width: 75, height: 75)
        //.background(.blue)
        .overlay(
            ZStack {
                if hasNewMessage {
                    Circle()
                        .fill(.bumbleWhite)
                    
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(4)
                }
            }
            .frame(width: 24, height: 24)
            .offset(x: 2, y: 2)
            , alignment: .bottomTrailing
        )
    }
}

#Preview {
    VStack {
        BumbleProfileImageCell(percentageRemaining: 1)
        BumbleProfileImageCell(percentageRemaining: 0)
        BumbleProfileImageCell(percentageRemaining: 0.8, hasNewMessage: false )
    }
}
