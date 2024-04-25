//
//  NetflixFilterCell.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 25/04/2024.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title: String = "Caterogies"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        //.clipShape(RoundedRectangle(cornerRadius: 32))
        .background(
            ZStack {
                
                if isSelected {
                    Capsule(style: .circular)
                        .fill(.netflixDarkGray)
                } else {
                    Capsule(style: .circular)
                        .stroke(lineWidth: 1)
                }

            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixFilterCell(isSelected: false)
            NetflixFilterCell(isSelected: true)
            NetflixFilterCell(isDropdown: false)
        }
    }
}
