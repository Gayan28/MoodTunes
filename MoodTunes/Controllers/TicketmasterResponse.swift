//
//  TicketmasterResponse.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import Foundation

struct TicketmasterResponse: Decodable {
    let embedded: EmbeddedEvents
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EmbeddedEvents: Decodable {
    let events: [TicketmasterEvent]
}

struct TicketmasterEvent: Decodable {
    let id: String?
    let name: String?
    let info: String?
    let images: [EventImage]
    let embedded: EmbeddedVenues
    
    enum CodingKeys: String, CodingKey {
        case id,name,info,images
        case embedded = "_embedded"
    }
}

struct EventImage: Decodable {
    let url: String?
}

struct EmbeddedVenues: Decodable {
    let venues: [Venue]
}

struct Venue: Decodable {
    let location: VenueLocation
}

struct VenueLocation: Decodable {
    let latitude: String
    let longitude: String
}
