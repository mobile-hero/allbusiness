// Business.swift

import Foundation

// MARK: - Business
struct Business: Codable {
    let id: String
    let alias: String
    let name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let transactions: [String]
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double
    let price: String?
}
