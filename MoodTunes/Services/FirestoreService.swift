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

            guard let documents = snapshot?.documents else {
                print("No concert documents found")
                return
            }

            self.events = documents.compactMap { doc in
                let event = Event(id: doc.documentID, data: doc.data())
                if event == nil {
                    print("Skipping invalid document: \(doc.documentID)")
                }
                return event
            }

            print("Fetched \(self.events.count) events.")
        }
    }
}
