import SwiftUI

struct EmotionsView: View {

    @StateObject private var viewModel: EmotionsViewModel

    // 2 columns grid
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    init(gender: ChildGender) {
        _viewModel = StateObject(wrappedValue: EmotionsViewModel(gender: gender))
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 16) {

                // الكبسولة الصفراء
                HStack {
                    Spacer()

                    Capsule()
                        .fill(Color(red: 0.98, green: 0.82, blue: 0.34))
                        .frame(height: 40)
                        .overlay(
                            Text("مشاعري")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                        )

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                // الشبكة
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.cards) { card in
                            NavigationLink {
                                EmotionDetailView(card: card, gender: viewModel.gender)
                            } label: {
                                VStack(spacing: 8) {
                                    // 👇 هنا نعرض الصورة من نفس الاسم اللي حطيتِه في EmotionDefinition
                                    Image(card.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)

                                    Text(card.title)
                                        .font(.system(size: 18))
                                        .foregroundColor(.black)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, minHeight: 140)
                                .background(Color(red: 1.0, green: 0.98, blue: 0.92))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                                )
                                .cornerRadius(16)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }

                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct EmotionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmotionsView(gender: .girl)   // or .boy
        }
    }
}
