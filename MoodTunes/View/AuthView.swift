import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AuthView: View {
    enum AuthTab: String, CaseIterable {
        case login = "Login"
        case register = "Register"
    }

    @State private var selectedTab: AuthTab = .login

    // Login States
    @State private var loginEmail = ""
    @State private var loginPassword = ""
    @State private var loginNavigateToVerification = false

    // Register States
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var registerNavigateToVerification = false

    @State private var errorMessage = ""
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 30)

                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 120)
                        .accessibilityHidden(true)

                    Text("MOODTUNES")
                        .font(.title)
                        .bold()
                        .kerning(2)
                        .foregroundColor(.black)
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityLabel("MoodTunes title")

                    Picker("Auth Type", selection: $selectedTab) {
                        ForEach(AuthTab.allCases, id: \.self) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 30)
                    .accessibilityLabel("Authentication Type")
                    .accessibilityHint("Switch between Login and Register")

                    if selectedTab == .login {
                        loginSection
                    } else {
                        registerSection
                    }

                    if isLoading {
                        ProgressView()
                            .padding(.top, 10)
                            .accessibilityLabel("Loading")
                            .accessibilityHint("Please wait")
                    }

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .accessibilityLabel("Error: \(errorMessage)")
                    }

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .ignoresSafeArea(.keyboard)
            .navigationDestination(isPresented: $registerNavigateToVerification) {
                VerificationScreen()
            }
            .navigationDestination(isPresented: $loginNavigateToVerification) {
                VerificationScreen()
            }
        }
    }

    var loginSection: some View {
        VStack(spacing: 15) {
            CustomTextField(placeholder: "Email", text: $loginEmail)
                .accessibilityLabel("Login Email")
                .accessibilityHint("Enter your registered email address")

            SecureTextField(placeholder: "Password", text: $loginPassword)
                .accessibilityLabel("Login Password")
                .accessibilityHint("Enter your password")

            Button(action: loginUser) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .accessibilityLabel("Sign In Button")
            .accessibilityHint("Tap to sign in to your account")
            .accessibilityAddTraits(.isButton)

            HStack {
                Text("Forgot password?")
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.7))
                    .accessibilityHidden(true)

                Button("Remember") {}
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .accessibilityLabel("Remember Password")
                    .accessibilityHint("Tap if you remembered your password")
            }

            HStack {
                Text("Don’t have an account?")
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.7))
                    .accessibilityHidden(true)

                Button("Register") {
                    selectedTab = .register
                }
                .font(.footnote)
                .foregroundColor(.blue)
                .accessibilityLabel("Register Button")
                .accessibilityHint("Tap to switch to registration")
            }
        }
        .accessibilityElement(children: .contain)
    }

    var registerSection: some View {
        VStack(spacing: 15) {
            CustomTextField(placeholder: "Full Name", text: $fullName)
                .accessibilityLabel("Full Name")
                .accessibilityHint("Enter your full name")

            CustomTextField(placeholder: "Email", text: $email)
                .accessibilityLabel("Register Email")
                .accessibilityHint("Enter your email address")

            SecureTextField(placeholder: "Password", text: $password)
                .accessibilityLabel("Register Password")
                .accessibilityHint("Enter a new password")

            SecureTextField(placeholder: "Confirm Password", text: $confirmPassword)
                .accessibilityLabel("Confirm Password")
                .accessibilityHint("Re-enter the password")

            Button(action: registerUser) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .accessibilityLabel("Sign Up Button")
            .accessibilityHint("Tap to create your new account")
            .accessibilityAddTraits(.isButton)

            HStack {
                Text("Already have an account?")
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.7))
                    .accessibilityHidden(true)

                Button("Login") {
                    selectedTab = .login
                }
                .font(.footnote)
                .foregroundColor(.blue)
                .accessibilityLabel("Login Button")
                .accessibilityHint("Tap to switch to login")
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func registerUser() {
        errorMessage = ""
        isLoading = true

        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            errorMessage = "Please fill all fields correctly."
            isLoading = false
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
                return
            }

            guard let uid = result?.user.uid else {
                DispatchQueue.main.async {
                    self.errorMessage = "User ID not found after signup."
                    self.isLoading = false
                }
                return
            }

            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "fullName": fullName,
                "email": email
            ]

            db.collection("users").document(uid).setData(userData) { err in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let err = err {
                        self.errorMessage = "Firestore error: \(err.localizedDescription)"
                    } else {
                        self.registerNavigateToVerification = true
                    }
                }
            }
        }
    }

    private func loginUser() {
        errorMessage = ""
        isLoading = true

        guard !loginEmail.isEmpty, !loginPassword.isEmpty else {
            errorMessage = "Please enter both email and password."
            isLoading = false
            return
        }

        Auth.auth().signIn(withEmail: loginEmail, password: loginPassword) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.loginNavigateToVerification = true
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
