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

                // كبسولة العنوان (برتقالي زي كرت الطعام في الصفحة الرئيسية)
                HStack {
                    Spacer()

                    Capsule()
                        .fill(Color(red: 0.95, green: 0.52, blue: 0.40))
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
                                // لو عندك شاشة تفاصيل للطعام حطيها هنا
                                // FoodDetailView(card: card)
                                Text(card.title)   // مؤقتاً
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

    // الكرت – نفس مقاس كرت المشاعر تماماً
    private func foodCardView(_ card: FoodViewModel.FoodCard) -> some View {
        VStack(spacing: 8) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)

            Text(card.title)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 1.0, green: 0.98, blue: 0.92)) // نفس خلفية المشاعر بس تقدرين تغيرينها
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
