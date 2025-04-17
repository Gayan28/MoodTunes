//
//  Event.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-17.
//

import Foundation
import MapKit
import SwiftUI

struct Event: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let color: Color
    let imageName: String
    let description: String
    let date: String
    let genre: String
    let venue: String
    
    init?(id: String, data: [String: Any]) {
        guard let name = data["name"] as? String,
              let latitude = data["latitude"] as? CLLocationDegrees,
              let longitude = data["longitude"] as? CLLocationDegrees,
              let colorString = data["color"] as? String,
              let imageName = data["imageName"] as? String,
              let description = data["description"] as? String,
              let date = data["date"] as? String,
              let genre = data["genre"] as? String,
              let venue = data["venue"] as? String else {
                  return nil
              }
        
        self.id = id
        self.name = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.color = Color(colorString)
        self.imageName = imageName
        self.description = description
        self.date = date
        self.genre = genre
        self.venue = venue
    }
}
