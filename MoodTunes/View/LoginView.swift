//
//  LoginScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegisterSelected = false

    var body: some View {
        VStack {
            Spacer().frame(height: 50)

            // Logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 202, height: 138)

            // Register/Login Toggle
            HStack(spacing: 0) {
                Button(action: {
                    isRegisterSelected = true
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(isRegisterSelected ? Color.white : Color.clear)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(isRegisterSelected ? Color.black : Color.clear, lineWidth: 1)
                        )
                }

                Button(action: {
                    isRegisterSelected = false
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(!isRegisterSelected ? Color.white : Color.clear)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(!isRegisterSelected ? Color.black : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 40)
            .frame(maxWidth: 250)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.vertical, 20)

            // Input Fields
            Group {
                CustomTextField(placeholder: "Email", text: $email)
                SecureTextField(placeholder: "Password", text: $password)
            }
            .padding(.horizontal, 30)

            // Sign In Button
            Button(action: {
                // Handle Sign In
            }) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)

            // Forgot Password
            HStack {
                Text("Forgot password?")
                    .foregroundColor(.black.opacity(0.7))
                Button(action: {
                    // Forgot Password action
                }) {
                    Text("Remember")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)

            // Register Redirect
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Button(action: {
                    // Navigate to Register Page
                }) {
                    Text("Register")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 5)

            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
