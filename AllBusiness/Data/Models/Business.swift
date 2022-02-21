// Business.swift

import Foundation
import CoreLocation

// MARK: - Business
struct Business: Codable {
    let id: String
    let alias: String
    let name: String
    let imageUrl: String
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
    
    var ratingDisplay: String {
        return rating.description
    }
    
    var categoriesDisplay: String {
        return categories.map { $0.title }.joined(separator: ", ")
    }
    
    var addressDisplay: String {
        return location.displayAddress.joined(separator: "\n")
    }
    
    var coordinatesTransformed: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    var phoneUrl: URL {
        return URL(string: "tel://\(phone)")!
    }
    
    var urlFormatted: URL {
        return URL(string: url)!
    }
}
