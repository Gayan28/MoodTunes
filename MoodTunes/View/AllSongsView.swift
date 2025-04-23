import SwiftUI

struct AllSongsView: View {
    let categories = [
        ("Happy Songs", "happysongs"),
        ("Sad Songs", "sadsongs"),
        ("Angry Songs", "angrysongs"),
        ("Relax Songs", "relaxsongs")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Let’s Discover")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .dynamicTypeSize(.xSmall ... .accessibility3)
                .minimumScaleFactor(0.8)
                .accessibilityLabel("Main heading: Let's Discover")

            Text("your next song to play!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .dynamicTypeSize(.xSmall ... .accessibility3)
                .minimumScaleFactor(0.8)
                .accessibilityLabel("Subtitle: your next song to play")

            Text("All Categories")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 10)
                .dynamicTypeSize(.xSmall ... .accessibility3)
                .minimumScaleFactor(0.8)
                .accessibilityLabel("Section heading: All Categories")

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                ForEach(categories, id: \.0) { category in
                    VStack {
                        Image(category.1)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .accessibilityHidden(true) // Hides image from VoiceOver

                        Text(category.0)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                            .dynamicTypeSize(.xSmall ... .accessibility3)
                            .minimumScaleFactor(0.8)
                            .accessibilityHidden(true) // Hidden to combine below
                    }
                    // Make the entire VStack an accessible element
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(category.0)")
                    .accessibilityHint("Double tap to explore \(category.0.lowercased())")
                    .accessibilityAddTraits(.isButton)
                }
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

struct AllSongsView_Previews: PreviewProvider {
    static var previews: some View {
        AllSongsView()
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .preferredColorScheme(.dark)
    }
}
