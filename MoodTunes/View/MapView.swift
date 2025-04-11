//
//  MapView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var events: [Event] = []
    @State private var selectedEvent: Event?
    
    var body: some View {
        VStack(spacing: 0) {
            // Map and Pins
            Map(coordinateRegion: $region, annotationItems: events) { event in
                MapAnnotation(coordinate: event.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .onTapGesture {
                                withAnimation {
                                    selectedEvent = event
                                }
                            }
                        Text(event.name)
                            .font(.caption)
                            .bold()
                            .padding(.top, -5)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .frame(height: 350)
            .overlay(
                VStack {
                    HStack {
                        TextField("Search", text: .constant(""))
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                }
            )

            // Popup view for selected event
            if let selected = selectedEvent {
                EventPopupView(event: selected) {
                    // Navigate to details
                    showEventDetails(selected)
                }
                .transition(.scale)
                .padding(.horizontal)
            }

            // Upcoming Events Horizontal Scroll
            VStack(alignment: .leading) {
                Text("Upcoming Events")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(events) { event in
                            AsyncImage(url: URL(string: event.imageURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 160)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedEvent = event
                                            region.center = event.coordinate
                                        }
                                    }
                            } placeholder: {
                                Color.gray
                                    .frame(width: 120, height: 160)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
            }
            .background(Color.black.opacity(0.95))
            .foregroundColor(.white)
        }
        .onAppear {
            fetchEvents()
        }
    }

    // Load Events
    private func fetchEvents() {
        let userLocation = CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612)
        TicketmasterAPI.shared.fetchEvents(near: userLocation) { fetchedEvents in
            self.events = fetchedEvents
        }
    }

    // Navigate to details (dummy logic for now)
    private func showEventDetails(_ event: Event) {
        // You can replace this with actual navigation
        print("Show details for:", event.name)
    }
}
 



