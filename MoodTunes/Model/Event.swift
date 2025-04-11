//
//  Event.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import Foundation
import MapKit

struct Event: Identifiable, Equatable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageURL: String
    let info: String

    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Song: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
    let duration: String?
}


