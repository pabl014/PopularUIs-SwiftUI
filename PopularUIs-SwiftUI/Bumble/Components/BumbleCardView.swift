//
//  BumbleCardView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 20/04/2024.
//

import SwiftUI

struct BumbleCardView: View {
    
    var user: User = .mockUser
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                
                ZStack(alignment: .bottomLeading) {
                    ImageLoaderView(urlString: user.image)
                        
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(user.firstName), \(user.age)")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "suitcase")
                            Text(user.work)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "graduationcap")
                            Text(user.education)
                        }
                        
                        BumbleHeartView()
                            .onTapGesture {
                                
                            }
                    }
                    .padding(24)
                    //.background(.red)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.bumbleWhite)
                }
                .frame(height: 600)
            }
        }
        .scrollIndicators(.hidden)
        //.clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
