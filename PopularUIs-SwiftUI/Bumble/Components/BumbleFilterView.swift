//
//  BumbleFilterView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 20/04/2024.
//

import SwiftUI

struct BumbleFilterView: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @State private var selection: String = "Everyone"
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        //.background(.red)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 1.5)
                    }
                }
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
    }
}

#Preview {
    
    VStack {
        BumbleFilterView()
            .padding()
        
        Spacer()
    }
}
