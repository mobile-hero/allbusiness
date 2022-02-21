// ReviewResponse.swift

import Foundation

// MARK: - ReviewResponse
struct ReviewResponse: Codable {
    let reviews: [Review]
    let total: Int
    let possibleLanguages: [String]
}

