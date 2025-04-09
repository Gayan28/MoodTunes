//
//  SettingsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedTab: TabItem
    @State private var isOfflineMode = false
    @State private var appearance = "Light"
    @State private var notificationsEnabled = true

    // Registered User Info
    let username = "gayan_k"
    let fullName = "Gayan Kavinda"
    let email = "gayan@example.com"

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    //Profile Section
                    Section(header: Text("Profile")) {
                        HStack {
                            Label("Username", systemImage: "person.circle")
                            Spacer()
                            Text(username)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Label("Full Name", systemImage: "person.fill")
                            Spacer()
                            Text(fullName)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Label("Email", systemImage: "envelope")
                            Spacer()
                            Text(email)
                                .foregroundColor(.secondary)
                        }

                        // Delete Account Button
                        Button(role: .destructive) {
                            // Add delete logic here
                        } label: {
                            Label("Delete Account", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                    }

                    // MARK: - Settings Section
                    Section(header: Text("App Settings")) {
                        Toggle(isOn: $isOfflineMode) {
                            Label("Offline Mode", systemImage: "wifi.slash")
                        }

                        Picker(selection: $appearance, label: Label("Appearance", systemImage: "paintbrush")) {
                            Text("Light").tag("Light")
                            Text("Dark").tag("Dark")
                        }
                        .pickerStyle(SegmentedPickerStyle())

                        Toggle(isOn: $notificationsEnabled) {
                            Label("Notifications", systemImage: "bell.fill")
                        }

                        Button {
                            // Add logout logic here
                        } label: {
                            Label("Logout", systemImage: "arrow.right.square")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.bottom, 70) // Space for tab bar
                .navigationTitle("My Account")

                // Custom Tab Bar
                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.9))
                    .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color(hex: "#0F0817"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings))
    }
}
