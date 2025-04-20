//
//  MapView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI
import MapKit
import Firebase
import CoreLocation

enum MapItem: Identifiable, Hashable, Equatable {
    case event(Event)
    case user(UserLocationAnnotation)

    var id: String {
        switch self {
        case .event(let event): return "event-\(event.id)"
        case .user: return "user-location"
        }
    }

    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .event(let event): return event.coordinate
        case .user(let user): return user.coordinate
        }
    }

    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MapView: View {
    @StateObject private var firestoreService = FirestoreService()
    @StateObject private var locationManager = LocationManager()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9105192, longitude: 79.8630272),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var selectedEvent: Event? = nil
    @State private var showPopup = false
    @State private var navigateToDetails = false
    @State private var searchText: String = ""

    @EnvironmentObject var theme: ThemeManager

    var eventsWithCoordinates: [Event] {
        let filtered = firestoreService.events.filter {
            $0.coordinate.latitude != 0 && $0.coordinate.longitude != 0
        }

        // Debug print
        print("Fetched \(firestoreService.events.count) events. Displaying \(filtered.count) on map.")
        return filtered
    }

    var filteredEvents: [Event] {
        if searchText.isEmpty {
            return firestoreService.events
        } else {
            return firestoreService.events.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var combinedAnnotations: [MapItem] {
        var items: [MapItem] = eventsWithCoordinates.map { MapItem.event($0) }
        if let userAnnotation = locationManager.userLocationAnnotation().first {
            items.append(.user(userAnnotation))
        }
        return items
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    Map(coordinateRegion: $region,
                        showsUserLocation: true,
                        annotationItems: combinedAnnotations) { item in
                        MapAnnotation(coordinate: item.coordinate) {
                            Group {
                                switch item {
                                case .event(let event):
                                    Button {
                                        selectedEvent = event
                                        showPopup = true
                                    } label: {
                                        VStack(spacing: 4) {
                                            Image(systemName: "mappin.circle.fill")
                                                .font(.system(size: 30))
                                                .foregroundColor(.red)
                                                .background(Circle().fill(Color.white).frame(width: 36, height: 36))

                                            Text(event.name)
                                                .font(.caption2)
                                                .foregroundColor(.black)
                                                .padding(4)
                                                .background(Color.white.opacity(0.9))
                                                .cornerRadius(6)
                                        }
                                    }

                                case .user:
                                    Image(systemName: "location.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.blue)
                                        .background(Circle().fill(Color.white).frame(width: 36, height: 36))
                                }
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 500)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .foregroundColor(.black)
                            .submitLabel(.done)
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                    if showPopup, let event = selectedEvent {
                        VStack {
                            Spacer()
                            VStack(spacing: 8) {
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
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.45)
                            .background(Color.black.opacity(0.92))
                            .cornerRadius(16)
                            .padding(.bottom, 80)
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showPopup)
                    }

                    NavigationLink(destination: selectedEvent.map { EventDetailsView(event: $0) },
                                   isActive: $navigateToDetails) {
                        EmptyView()
                    }
                }

                VStack(alignment: .leading) {
                    Text("Upcoming Events")
                        .font(.headline)
                        .foregroundColor(theme.textPrimary)
                        .padding(.horizontal)
                        .padding(.top, 10)

                    ZStack {
                        if filteredEvents.isEmpty {
                            HStack {
                                Spacer()
                                Text("No results found.")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                                    .frame(height: 160)
                                Spacer()
                            }
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
                        }
                    }
                    .frame(height: 160)
                    .padding(.bottom, 12)
                }
                .background(theme.background)
                .padding(.bottom, 70)
            }
            .background(theme.background.edgesIgnoringSafeArea(.bottom))
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
            .environmentObject(ThemeManager())
    }
}
