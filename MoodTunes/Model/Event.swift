//
//  Event.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import Foundation
import MapKit

struct Event: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageURL: String
    let info: String
}

 
