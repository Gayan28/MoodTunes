//
//  MapView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var selectedTab: TabItem

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 7.054, longitude: 80.014),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var events: [Event] = []
    @State private var selectedEvent: Event? = nil
    @State private var showDetails = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Map(coordinateRegion: $region, annotationItems: events) { event in
                        MapAnnotation(coordinate: event.coordinate) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)

                                Text(event.name)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .onTapGesture {
                                selectedEvent = event
                            }
                        }
                    }
                    .ignoresSafeArea()

                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()

                    // Popup view
                    if let event = selectedEvent {
                        VStack {
                            Spacer()
                            EventPopupView(event: event) {
                                showDetails = true
                            }
                            .padding()
                        }
                        .transition(.move(edge: .bottom))
                    }

                    // Horizontal event scroll with CategoryCard
                    VStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Upcoming Events")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(events) { event in
                                        CategoryCard2(imageURL: event.imageURL, title: event.name)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedEvent = event
                                                    centerMap(on: event)
                                                }
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 90)
                        .background(Color(hex: "#0F0817"))
                    }

                    // Navigation to detail screen
                    NavigationLink(
                        destination: Group {
                            if let event = selectedEvent {
                                EventDetailsView(event: event)
                            }
                        },
                        isActive: $showDetails
                    ) {
                        EmptyView()
                    }
                }

                // Custom Tab Bar
                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.9))
                    .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                fetchEvents()
            }
            .background(Color(hex: "#0F0817"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }

    func fetchEvents() {
        TicketmasterAPI.shared.fetchEvents(near: region.center) { events in
            self.events = events
        }
    }

    func centerMap(on event: Event) {
        region = MKCoordinateRegion(
            center: event.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(selectedTab: .constant(.map))
    }
}
