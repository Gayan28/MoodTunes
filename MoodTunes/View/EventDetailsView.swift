//
//  EventDetailsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import SwiftUI
import CoreLocation

struct EventDetailsView: View {
    let event: Event
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Concert Details")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            HStack {
                Spacer()
                Image(event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(width: 300)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)

                Text(event.genre)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date and Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(event.date)
                        .foregroundColor(.white)
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Venue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(event.venue)
                        .foregroundColor(.white)
                        .font(.body)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("About the Concert")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                openGoogleMapsDirections()
            }) {
                Text("Directions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .tabBar)
    }

    func openGoogleMapsDirections() {
        guard let currentLocation = locationManager.userLocation else {
            print("Current location not available")
            return
        }

        let sourceLat = currentLocation.latitude
        let sourceLng = currentLocation.longitude
        let destLat = event.coordinate.latitude
        let destLng = event.coordinate.longitude

        let googleMapsAppURL = "comgooglemaps://?saddr=\(sourceLat),\(sourceLng)&daddr=\(destLat),\(destLng)&directionsmode=driving"
        let fallbackWebURL = "https://www.google.com/maps/dir/?api=1&origin=\(sourceLat),\(sourceLng)&destination=\(destLat),\(destLng)&travelmode=driving"

        if let appURL = URL(string: googleMapsAppURL),
           UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else if let webURL = URL(string: fallbackWebURL) {
            UIApplication.shared.open(webURL)
        } else {
            print("Cannot open Google Maps")
        }
    }
}
