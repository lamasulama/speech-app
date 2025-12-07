
import SwiftUI

struct FoodView: View {

    @StateObject private var viewModel = FoodViewModel()

    // نفس أعمدة EmotionsView بالضبط
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 16) {

                // كبسولة العنوان
                HStack {
                    Spacer()

                    Capsule()
                        .fill(Color(red: 0.95, green: 0.52, blue: 0.40)) // اللون البرتقالي للطعام
                        .frame(height: 40)
                        .overlay(
                            Text("الطعام")
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
                                FoodDetailView(card: card)
                            } label: {

                                foodCardView(card)
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

    // كرت الطعام — Light Peach + نفس مقاسات المشاعر
    private func foodCardView(_ card: FoodViewModel.FoodCard) -> some View {
        VStack(spacing: 8) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)  // نفس المشاعر

            Text(card.title)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 140) // نفس ارتفاع كرت المشاعر
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "FFE6D5"))   // ⭐ Light Peach
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
        )
        .cornerRadius(16)
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FoodView()
        }
    }
}
