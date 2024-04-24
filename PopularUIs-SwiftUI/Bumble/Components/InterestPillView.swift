//
//  InterestPillView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 22/04/2024.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String? = "heart.fill"
    var emoji: String? = "😎"
    var text: String = "Playing Football"
    
    var body: some View {
        HStack(spacing: 4) {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    
    VStack {
        InterestPillView()
        InterestPillView(iconName: "heart", text: "Hi bro")
        InterestPillView(iconName: nil, text: "dab")
    }
}
