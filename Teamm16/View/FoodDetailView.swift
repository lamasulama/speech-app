import SwiftUI

struct FoodDetailView: View {

    let card: FoodViewModel.FoodCard
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedReaction: String? = nil
    
    // نفس لون الكارد في DailySkillDetailView
    private let cardBackground = Color(hex: "FFE6D5")
    
    // نفس الإيموجيز
    private let emojis = ["👎", "👍", "❤️", "😊"]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 24) {

                // زر الرجوع – نفس DailySkillDetailView
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(radius: 2)
                            )
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // الكرت الكبير – نفس السايز تماماً
                VStack {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: 360)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(cardBackground)   // أزرق فاتح مثل ديلي سكلز
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1.2)
                )
                .padding(.horizontal, 24)

                // العنوان – نفس الزر الأصفر في DailySkillDetailView
                Text(card.title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.98, green: 0.82, blue: 0.34)) // الأصفر نفسه
                            .shadow(radius: 3)
                    )
                    .padding(.horizontal, 40)

                Spacer()

                // صف الإيموجيز – نفس ستايل DailySkillDetailView
                reactionRow
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - صف التفاعل
    private var reactionRow: some View {
        HStack(spacing: 18) {
            ForEach(emojis, id: \.self) { emoji in
                Button {
                    selectedReaction = emoji
                } label: {
                    Circle()
                        .fill(
                            selectedReaction == emoji
                            ? Color.green.opacity(0.2)
                            : Color.white
                        )
                        .frame(width: 56, height: 56)
                        .overlay(
                            Text(emoji)
                                .font(.system(size: 28))
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.black.opacity(0.12), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
}
