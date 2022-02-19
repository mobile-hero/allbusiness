// BusinessResponse.swift

import Foundation

// MARK: - BusinessResponse
struct BusinessResponse: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region
}
