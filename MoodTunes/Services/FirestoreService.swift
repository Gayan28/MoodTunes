//
//  FirestoreService.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-17.
//

import Foundation
import FirebaseFirestore

class FirestoreService: ObservableObject {
    @Published var events: [Event] = []

    private var db = Firestore.firestore()

    func fetchEvents() {
        db.collection("concerts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }
            self.events = documents.compactMap { doc in
                Event(id: doc.documentID, data: doc.data())
            }
        }
    }
}
