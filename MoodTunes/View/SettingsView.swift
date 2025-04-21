//  SettingsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SettingsView: View {
    enum ActiveAlert {
        case logout, deleteAccount, success
    }

    @State private var isOfflineMode = false
    @State private var appearance = "Light"
    @State private var notificationsEnabled = true

    @State private var fullName = "Loading..."
    @State private var email = "Loading..."

    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert?
    @State private var successMessageText = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#0F0817")
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
                                activeAlert = .deleteAccount
                                showAlert = true
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

                            Button(action: {
                                activeAlert = .logout
                                showAlert = true
                            }) {
                                Label("Logout", systemImage: "arrow.right.square")
                                    .foregroundColor(.red)
                            }
                            .listRowBackground(Color(hex: "#EBEDF0"))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color(hex: "#0F0817"))
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .onAppear(perform: fetchUserData)
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .logout:
                    return Alert(
                        title: Text("Are you sure you want to logout?"),
                        primaryButton: .destructive(Text("Logout")) {
                            logout()
                        },
                        secondaryButton: .cancel()
                    )
                case .deleteAccount:
                    return Alert(
                        title: Text("Are you sure you want to delete your account?"),
                        message: Text("This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            deleteAccount()
                        },
                        secondaryButton: .cancel()
                    )
                case .success:
                    return Alert(
                        title: Text(successMessageText),
                        dismissButton: .default(Text("OK")) {
                            if successMessageText.contains("successfully") {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    exit(0)
                                }
                            }
                        }
                    )
                case .none:
                    return Alert(title: Text("Unknown error"))
                }
            }
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
        do {
            try Auth.auth().signOut()
            fullName = "Logged Out"
            email = "Logged Out"
            successMessageText = "You have been logged out successfully."
            activeAlert = .success
            showAlert = true
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }

    private func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.delete { error in
            if let error = error {
                print("Error deleting user data from Firestore: \(error.localizedDescription)")
                return
            }

            user.delete { error in
                if let error = error {
                    print("Error deleting user account: \(error.localizedDescription)")
                } else {
                    fullName = "Deleted"
                    email = "Deleted"
                    successMessageText = "Account deleted successfully."
                    activeAlert = .success
                    showAlert = true
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
