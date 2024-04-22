//
//  User.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 08/04/2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    var work = "Worker at some job"
    var education = "Graduate degree"
    var aboutMe = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    static var mockUser: User {
        User(
            id: 345,
            firstName: "Pablo",
            lastName: "Alvarez",
            age: 23,
            email: "pablo@alvarez.com",
            phone: "123456789",
            username: "pabloAlvarez123",
            password: "siema",
            image: Constants.randomImage,
            height: 178,
            weight: 83.5
        )
    }
}


struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}
