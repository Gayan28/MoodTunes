//
//  SettingsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SettingsView: View {
    @Binding var selectedTab: TabItem
    @State private var isOfflineMode = false
    @State private var appearance = "Light"
    @State private var notificationsEnabled = true

    @State private var fullName = "Loading..."
    @State private var email = "Loading..."

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color(hex: "#0F0817") // background color
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 10) {
                    Text("My Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top)

                    List {
                        Section(header: Text("Profile").foregroundColor(.white)) {
                            HStack {
                                Label("Full Name", systemImage: "person.fill")
                                Spacer()
                                Text(fullName)
                                    .foregroundColor(.secondary)
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))

                            HStack {
                                Label("Email", systemImage: "envelope")
                                Spacer()
                                Text(email)
                                    .foregroundColor(.secondary)
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))

                            Button(role: .destructive) {
                                deleteAccount()
                            } label: {
                                Label("Delete Account", systemImage: "trash")
                                    .foregroundColor(.red)
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))
                        }

                        Section(header: Text("App Settings").foregroundColor(.white)) {
                            Toggle(isOn: $isOfflineMode) {
                                Label("Offline Mode", systemImage: "wifi.slash")
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))

                            Picker(selection: $appearance, label: Label("Appearance", systemImage: "paintbrush")) {
                                Text("Light").tag("Light")
                                Text("Dark").tag("Dark")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .listRowBackground(Color(hex: "#EBEDF0"))

                            Toggle(isOn: $notificationsEnabled) {
                                Label("Notifications", systemImage: "bell.fill")
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))

                            Button(action: logout) {
                                Label("Logout", systemImage: "arrow.right.square")
                                    .foregroundColor(.red)
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color(hex: "#0F0817")) // list background
                    .listStyle(InsetGroupedListStyle())
                    .padding(.bottom, 70)
                }

                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.9))
                    .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear(perform: fetchUserData)
        }
    }

    private func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            fullName = "Not logged in"
            email = "Not logged in"
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                fullName = "Error"
                email = "Error"
                return
            }

            guard let document = document, document.exists,
                  let data = document.data() else {
                fullName = "No data"
                email = "No data"
                return
            }

            fullName = data["fullName"] as? String ?? "No Name"
            email = data["email"] as? String ?? "No Email"
        }
    }

    private func logout() {
        try? Auth.auth().signOut()
    }

    private func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }

        user.delete { error in
            if let error = error {
                print("Delete error: \(error.localizedDescription)")
            } else {
                print("Account deleted.")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings))
    }
}
