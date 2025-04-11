//
//  MapView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI
import MapKit

struct EventLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let color: Color
}

struct EventPoster: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9050, longitude: 79.9520),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let eventLocations: [EventLocation] = [
        EventLocation(name: "Yuganthaya", coordinate: CLLocationCoordinate2D(latitude: 6.9000, longitude: 79.9600), color: .yellow),
        EventLocation(name: "Sangeethe", coordinate: CLLocationCoordinate2D(latitude: 6.8700, longitude: 79.9400), color: .red),
        EventLocation(name: "Daddy Live", coordinate: CLLocationCoordinate2D(latitude: 6.8800, longitude: 80.0100), color: .red)
    ]
    
    let posters: [EventPoster] = [
        EventPoster(imageName: "concert", title: "Sihinaye"),
        EventPoster(imageName: "concert", title: "Aluth Kalawak"),
        EventPoster(imageName: "concert", title: "Wayo Live")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MAP + SEARCH
                ZStack(alignment: .top) {
                    Map(coordinateRegion: $region, annotationItems: eventLocations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(location.color)
                                Text(location.name)
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .padding(2)
                                    .background(Color.white.opacity(0.75))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 500)
                    
                    // SEARCH BAR
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: .constant(""))
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                }
                
                // POSTER-STYLE UPCOMING EVENTS
                VStack(alignment: .leading) {
                    Text("Upcoming Events")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(posters) { event in
                                NavigationLink(destination: EventDetailsView()) {
                                    VStack(spacing: 6) {
                                        Image(event.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 110, height: 140)
                                            .clipped()
                                            .cornerRadius(12)
                                        
                                        Text(event.title)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                }
                .background(Color.black)
                .padding(.bottom, 70) // Padding for tab bar
            }
            .background(Color.black.edgesIgnoringSafeArea(.bottom))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
