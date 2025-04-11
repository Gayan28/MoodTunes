//
//  EventDetailsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import SwiftUI
import MapKit

struct EventDetailsView: View {
    let event: Event

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: event.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 200)
                .cornerRadius(12)

                Text(event.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(event.info)
                    .font(.body)

                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: event.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )), annotationItems: [event]) { event in
                    MapMarker(coordinate: event.coordinate, tint: .blue)
                }
                .frame(height: 200)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

