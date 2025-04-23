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

    @State private var showFullNameSheet = false
    @State private var showEmailSheet = false
    @State private var showPasswordSheet = false

    @State private var editedFullName = ""
    @State private var editedEmail = ""

    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    // Password visibility
    @State private var showNewPassword = false
    @State private var showConfirmPassword = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#0F0817").ignoresSafeArea()

                VStack(alignment: .leading, spacing: 10) {
                    Text("My Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top)

                    List {
                        Section(header: Text("Profile").foregroundColor(.white)) {
                            Button {
                                editedFullName = fullName
                                showFullNameSheet = true
                            } label: {
                                profileRow(label: "Full Name", value: fullName, icon: "person.fill")
                            }

                            Button {
                                editedEmail = email
                                showEmailSheet = true
                            } label: {
                                profileRow(label: "Email", value: email, icon: "envelope")
                            }

                            Button {
                                showPasswordSheet = true
                            } label: {
                                profileRow(label: "Password", value: "********", icon: "lock.fill")
                            }

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
                        primaryButton: .destructive(Text("Logout")) { logout() },
                        secondaryButton: .cancel()
                    )
                case .deleteAccount:
                    return Alert(
                        title: Text("Are you sure you want to delete your account?"),
                        message: Text("This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) { deleteAccount() },
                        secondaryButton: .cancel()
                    )
                case .success:
                    return Alert(title: Text(successMessageText), dismissButton: .default(Text("OK")))
                case .none:
                    return Alert(title: Text("Unknown error"))
                }
            }
            .navigationBarHidden(true)

            // Full Name Sheet
            .sheet(isPresented: $showFullNameSheet) {
                VStack(spacing: 20) {
                    Text("Edit Full Name").font(.title2).bold()
                    TextField("Full Name", text: $editedFullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Save") {
                        updateField("fullName", value: editedFullName)
                        fullName = editedFullName
                        showFullNameSheet = false
                    }
                    .buttonStylePrimary()

                    Spacer()
                }.padding()
            }

            // Email Sheet
            .sheet(isPresented: $showEmailSheet) {
                VStack(spacing: 20) {
                    Text("Edit Email").font(.title2).bold()
                    TextField("Email", text: $editedEmail)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Save") {
                        updateField("email", value: editedEmail)
                        email = editedEmail
                        showEmailSheet = false
                    }
                    .buttonStylePrimary()

                    Spacer()
                }.padding()
            }

            // Password Sheet with Eye Icons
            .sheet(isPresented: $showPasswordSheet) {
                VStack(spacing: 20) {
                    Text("Change Password").font(.title2).bold()

                    SecureField("Current Password", text: $currentPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Group {
                            if showNewPassword {
                                TextField("New Password", text: $newPassword)
                            } else {
                                SecureField("New Password", text: $newPassword)
                            }
                        }
                        Button(action: {
                            showNewPassword.toggle()
                        }) {
                            Image(systemName: showNewPassword ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                    HStack {
                        Group {
                            if showConfirmPassword {
                                TextField("Confirm New Password", text: $confirmPassword)
                            } else {
                                SecureField("Confirm New Password", text: $confirmPassword)
                            }
                        }
                        Button(action: {
                            showConfirmPassword.toggle()
                        }) {
                            Image(systemName: showConfirmPassword ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                    Button("Update Password") {
                        guard newPassword == confirmPassword else {
                            successMessageText = "Passwords do not match."
                            activeAlert = .success
                            showAlert = true
                            return
                        }
                        reauthenticateAndChangePassword()
                        showPasswordSheet = false
                    }
                    .buttonStylePrimary()

                    Spacer()
                }.padding()
            }
        }
    }

    // MARK: - Profile Row
    private func profileRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text(value).foregroundColor(.secondary)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .listRowBackground(Color(hex: "#EBEDF0"))
    }

    private func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            fullName = "Not logged in"
            email = "Not logged in"
            return
        }
        Firestore.firestore().collection("users").document(uid).getDocument { document, _ in
            if let data = document?.data() {
                fullName = data["fullName"] as? String ?? "No Name"
                email = data["email"] as? String ?? "No Email"
            }
        }
    }

    private func updateField(_ key: String, value: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).updateData([key: value]) { error in
            if let error = error {
                print("Error updating \(key): \(error.localizedDescription)")
            }
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            fullName = "Logged Out"
            email = "Logged Out"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }

    private func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().collection("users").document(user.uid).delete { error in
            if let error = error {
                print("Firestore delete error: \(error.localizedDescription)")
                return
            }
            fullName = "Deleted"
            email = "Deleted"
            successMessageText = "Account deleted successfully."
            activeAlert = .success
            showAlert = true
        }
    }

    private func reauthenticateAndChangePassword() {
        guard let user = Auth.auth().currentUser,
              let email = user.email else { return }

        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)

        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                successMessageText = "Auth failed: \(error.localizedDescription)"
                activeAlert = .success
                showAlert = true
                return
            }

            user.updatePassword(to: newPassword) { error in
                successMessageText = error != nil ? "Update failed: \(error!.localizedDescription)" : "Password updated successfully."
                activeAlert = .success
                showAlert = true
            }
        }
    }
}

// MARK: - Primary Button Style
extension View {
    func buttonStylePrimary() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
