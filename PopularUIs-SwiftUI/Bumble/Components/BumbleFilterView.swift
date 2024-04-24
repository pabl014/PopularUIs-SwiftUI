//
//  BumbleFilterView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 20/04/2024.
//

import SwiftUI

struct BumbleFilterView: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @Binding var selection: String
    @Namespace private var namespace
    
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
                            .matchedGeometryEffect(id: "selection", in: namespace)
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
        .animation(.smooth, value: selection)
    }
}


// this is how it's going to be called in
fileprivate struct BumbleFilterViewPreview: View {
    
    var options: [String] = ["Everyone", "Trending", "siemson"]
    @State private var selection = "Everyone"
    
    var body: some View {
        BumbleFilterView(options: options, selection: $selection)
    }
}


#Preview {
    
    VStack {
        BumbleFilterViewPreview()
            .padding()
        
        Spacer()
    }
}
