// User.swift

import Foundation

// MARK: - User
struct User: Codable {
    let id: String
    let profileUrl: String
    let imageUrl: String?
    let name: String
}
