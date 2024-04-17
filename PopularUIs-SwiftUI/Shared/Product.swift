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
    
    
    static var mockProduct: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "Description goes here",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 76,
            brand: "Apple",
            category: "Electronic devices",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage]
        )
    }
}


struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}


struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
