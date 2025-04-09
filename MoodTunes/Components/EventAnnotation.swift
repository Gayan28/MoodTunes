//
//  EventAnnotation.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let event: Event

    init(event: Event) {
        self.event = event
        self.title = event.name
        self.coordinate = event.coordinate
    }
}
