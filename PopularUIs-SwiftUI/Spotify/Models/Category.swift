//
//  Category.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 15/04/2024.
//

import Foundation

// :String -> to get raw values of things in enum
// :CaseIterable -> to create an array to loop on all of values in enum

enum Category: String, CaseIterable {
    case all, music, podcasts, audiobooks
}
