//
//  ParseJson.swift
//  PlacesApiTutorial
//
//  Created by Lucas Daniel Costa da Silva on 08/07/24.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    var nationalPhoneNumber: String
    var rating: Double
    var displayName: DisplayName
    var currentOpeningHours: CurrentOpeningHours
    var shortFormattedAddress: String
    var editorialSummary: DisplayName
    var photos: [Photo]
    var accessibilityOptions: AccessibilityOptions
}

// MARK: - AccessibilityOptions
struct AccessibilityOptions: Codable {
    var wheelchairAccessibleParking, wheelchairAccessibleEntrance: Bool
}

// MARK: - CurrentOpeningHours
struct CurrentOpeningHours: Codable {
    var openNow: Bool
    var periods: [Period]
    var weekdayDescriptions: [String]
}

// MARK: - Period
struct Period: Codable {
    var periodOpen, close: Close

    enum CodingKeys: String, CodingKey {
        case periodOpen = "open"
        case close
    }
}

// MARK: - Close
struct Close: Codable {
    var day, hour, minute: Int
    var date: DateClass
}

// MARK: - DateClass
struct DateClass: Codable {
    var year, month, day: Int
}

// MARK: - DisplayName
struct DisplayName: Codable {
    var text, languageCode: String
}

// MARK: - Photo
struct Photo: Codable {
    var name: String
    var widthPx, heightPx: Int
    var authorAttributions: [AuthorAttribution]
}

// MARK: - AuthorAttribution
struct AuthorAttribution: Codable {
    var displayName, uri, photoURI: String

    enum CodingKeys: String, CodingKey {
        case displayName, uri
        case photoURI = "photoUri"
    }
}
