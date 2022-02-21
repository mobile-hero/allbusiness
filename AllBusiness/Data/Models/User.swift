// User.swift

import Foundation

// MARK: - User
struct User: Codable {
    let id: String
    let profileURL: String
    let imageURL: String?
    let name: String
}
