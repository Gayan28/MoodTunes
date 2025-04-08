//
//  RegisterScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct RegisterView: View {
    @State private var fullName = ""
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isRegisterSelected = true
    @State private var navigateToLogin = false
    @State private var navigateToVerification = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center) {
                    // Logo
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 202, height: 138)
                        .padding(.top, 50)

                    // App Name
                    Text("MOODTUNES")
                        .font(.custom("Times New Roman", size: 24))
                        .foregroundColor(.black)
                        .kerning(2)

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

                        NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                            Button(action: {
                                isRegisterSelected = false
                                navigateToLogin = true
                            }) {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(!isRegisterSelected ? Color.white : Color.clear)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: 250)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)

                    // Input Fields
                    Group {
                        CustomTextField(placeholder: "Full Name", text: $fullName)
                        CustomTextField(placeholder: "User Name", text: $userName)
                        CustomTextField(placeholder: "Email", text: $email)
                        SecureTextField(placeholder: "Password", text: $password)
                        SecureTextField(placeholder: "Confirm Password", text: $confirmPassword)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 10)

                    // Sign Up Button
                    Button(action: {
                        navigateToVerification = true
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 10)

                    // Navigate to VerificationScreen
                    NavigationLink(destination: VerificationScreen(), isActive: $navigateToVerification) {
                        EmptyView()
                    }

                    // Conditions Text
                    HStack {
                        Text("By signing up, you accept our")
                            .foregroundColor(.black.opacity(0.7))
                        Text("conditions")
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)

                    // Login Redirect
                    HStack {
                        Text("Have an account?")
                            .foregroundColor(.black.opacity(0.7))
                        Button(action: {
                            navigateToLogin = true
                        }) {
                            Text("Login")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 5)

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .ignoresSafeArea(.keyboard) 
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
