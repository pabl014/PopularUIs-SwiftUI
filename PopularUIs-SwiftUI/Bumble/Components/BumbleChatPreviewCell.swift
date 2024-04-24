//
//  BumbleChatPreviewCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 24/04/2024.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName: String = "Pablo"
    var lastChatMessage: String? = "Lorem ipsum began as scrambledddd, nonsensical Latin derived from Cicero's 1st-century BC text De Finibus Bonorum et Malorum."
    var isYourMove: Bool = true
    
    var body: some View {
        HStack(spacing: 16) {
            
            BumbleProfileImageCell(
                imageName: imageName,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage
            )
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text(userName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isYourMove {
                        Text("YOUR MOVE")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.bumbleYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                }
                
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing, 16)
                }
            }
            .lineLimit(1)
            //.background(.blue)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        
        BumbleChatPreviewCell()
        
        BumbleChatPreviewCell(
            hasNewMessage: false,
            userName: "Uvuvuevuevue",
            lastChatMessage: nil,
            isYourMove: false
        )
        
        BumbleChatPreviewCell(
            hasNewMessage: true,
            userName: "Layla",
            lastChatMessage: "Wa gwaan rude bwoy",
            isYourMove: false
        )
        
        BumbleChatPreviewCell(
            hasNewMessage: false,
            userName: "AaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
            lastChatMessage: "Hi",
            isYourMove: true
        )
    }
    .padding()
}
