//
//  SplashScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI
import LocalAuthentication
import AuthenticationServices

// MARK: - Face ID Manager
class FaceIDManager {
    static func isFaceIDAvailable() -> Bool {
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return canEvaluate && context.biometryType == .faceID
    }

    static func authenticateWithFaceID(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in to MoodTunes with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        let errorMessage = authenticationError?.localizedDescription ?? "Face ID authentication failed"
                        completion(false, errorMessage)
                    }
                }
            }
        } else {
            let errorMessage = error?.localizedDescription ?? "Face ID not available on this device"
            completion(false, errorMessage)
        }
    }
}

// MARK: - Splash Screen View
struct SplashScreen: View {
    @State private var showAlert = false
    @State private var faceIDMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                // Logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 230)
                
                // Tagline
                Text("MoodTunes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("Let Your Emotions Play")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 16) {
                    NavigationLink(destination: AuthView()) {
                        Text("Sign In")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                    
                    NavigationLink(destination: AuthView()) {
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)

                    Text("or")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 6)

                    // Apple Sign-In with Face ID check
                    SignInWithAppleButton(
                        .signIn,
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            if FaceIDManager.isFaceIDAvailable() {
                                FaceIDManager.authenticateWithFaceID { success, message in
                                    if success {
                                        faceIDMessage = "Successfully authenticated with Face ID and Apple ID."
                                        // Navigate or unlock the next screen here
                                    } else {
                                        faceIDMessage = message ?? "Face ID authentication failed"
                                    }
                                    showAlert = true
                                }
                            } else {
                                faceIDMessage = "Face ID not available on this device"
                                showAlert = true
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .cornerRadius(14)
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Authentication"), message: Text(faceIDMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

// MARK: - Preview
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .preferredColorScheme(.dark)
    }
}
