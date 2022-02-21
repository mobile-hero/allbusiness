// Review.swift

import Foundation

// MARK: - Review
struct Review: Codable {
    let id: String
    let url: String
    let text: String
    let rating: Int
    let timeCreated: String
    let user: User
}


