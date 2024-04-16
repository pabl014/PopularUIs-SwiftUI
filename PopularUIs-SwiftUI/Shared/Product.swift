//
//  Product.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 08/04/2024.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
}


struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}
