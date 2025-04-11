//
//  TicketmasterAPI.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import Foundation
import CoreLocation
import MapKit

class TicketmasterAPI {
    static let shared = TicketmasterAPI()
    private init() {}

    let apiKey = "gGICqOSWXw2eMrqLHAXBf6GG4nQAbo3y"

    func fetchEvents(near location: CLLocationCoordinate2D, completion: @escaping ([Event]) -> Void) {
        let lat = location.latitude
        let lon = location.longitude
        let radius = 50

        let urlString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(apiKey)&latlong=\(lat),\(lon)&radius=\(radius)&unit=km&classificationName=music"

        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching events:", error)
                completion([])
                return
            }

            guard let data = data else {
                print("No data")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(TicketmasterResponse.self, from: data)

                let events = decoded.embedded.events.compactMap { event -> Event? in
                    guard
                        let name = event.name,
                        let id = event.id,
                        let info = event.info,
                        let lat = event.embedded.venues.first?.location.latitude,
                        let lon = event.embedded.venues.first?.location.longitude,
                        let imageURL = event.images.first?.url,
                        let latitude = Double(lat),
                        let longitude = Double(lon)
                    else {
                        return nil
                    }

                    return Event(
                        id: id,
                        name: name,
                        coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                        imageURL: imageURL,
                        info: info
                    )
                }

                DispatchQueue.main.async {
                    completion(events)
                }
            } catch {
                print("JSON Decode error: \(error)")
                completion([])
            }
        }.resume()
    }
} 
