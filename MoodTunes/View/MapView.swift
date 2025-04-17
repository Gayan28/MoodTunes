//
//  MapView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI
import MapKit
import Firebase

struct MapView: View {
    @StateObject private var firestoreService = FirestoreService()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9050, longitude: 79.9520),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var selectedEvent: Event? = nil
    @State private var showPopup = false
    @State private var navigateToDetails = false
    @State private var searchText: String = ""

    var filteredEvents: [Event] {
        if searchText.isEmpty {
            return firestoreService.events
        } else {
            return firestoreService.events.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MAP + SEARCH
                ZStack(alignment: .top) {
                    Map(coordinateRegion: $region, annotationItems: filteredEvents) { event in
                        MapAnnotation(coordinate: event.coordinate) {
                            Button {
                                selectedEvent = event
                                showPopup = true
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.red)
                                        .background(
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 36, height: 36)
                                        )
                                    
                                    Text(event.name)
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                        .padding(4)
                                        .background(Color.white.opacity(0.9))
                                        .cornerRadius(6)
                                }
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 500)
                    
                    // SEARCH BAR
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .foregroundColor(.primary)
                            .onSubmit {
                                showPopup = false
                            }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                    
                    // POPUP VIEW
                    if showPopup, let event = selectedEvent {
                        VStack {
                            Spacer()
                            VStack(spacing: 8) {
                                // Close button
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showPopup = false
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .padding(.trailing, 4)
                                    }
                                }

                                Image(event.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 130)
                                    .cornerRadius(8)

                                Text(event.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                NavigationLink(destination: EventDetailsView(event: event)
                                    .onDisappear {
                                        selectedEvent = nil
                                        showPopup = false
                                    }, isActive: $navigateToDetails) {
                                    Button("More Details") {
                                        showPopup = false
                                        navigateToDetails = true
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 14)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                            .background(Color.black.opacity(0.92))
                            .cornerRadius(16)
                            .padding(.bottom, 80)
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showPopup)
                    }
                }
                
                // POSTER-STYLE UPCOMING EVENTS
                VStack(alignment: .leading) {
                    Text("Upcoming Events")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    if filteredEvents.isEmpty {
                        Text("No results found.")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(filteredEvents) { event in
                                    NavigationLink(destination: EventDetailsView(event: event)) {
                                        VStack(spacing: 6) {
                                            Image(event.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 110, height: 140)
                                                .clipped()
                                                .cornerRadius(12)
                                            
                                            Text(event.name)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 110)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 12)
                    }
                }
                .background(Color.black)
                .padding(.bottom, 70)
            }
            .background(Color.black.edgesIgnoringSafeArea(.bottom))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                firestoreService.fetchEvents()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
