import SwiftUI

struct FoodDetailView: View {

    let card: FoodViewModel.FoodCard
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedReaction: String? = nil
    
    private let emojis = ["👎", "👍", "❤️", "😊"]

    // لون الكرت البيتش
    private let cardBackground = Color(hex: "FFE6D5")

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 24) {

                // 🔙 زر رجوع واحد فقط (نفس ديلي سكلز)
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

                // 🔶 الكرت – نفس مقاس DailySkillDetailView بالضبط لكن Peach
                VStack {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: 360)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(cardBackground)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1.2)
                )
                .padding(.horizontal, 24)

                // 🔶 العنوان داخل كابسولة بنفس عرض ديلي سكلز، بلون Peach
                Text(card.title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(cardBackground)
                            .shadow(radius: 3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.black.opacity(0.18), lineWidth: 1.2)
                    )
                    .padding(.horizontal, 40)

                Spacer()

                // 😄 صف الإيموجيز في الأسفل (بدون زر تم تحتها)
                HStack(spacing: 18) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button {
                            selectedReaction = emoji
                        } label: {
                            Text(emoji)
                                .font(.system(size: 34))
                                .frame(width: 70, height: 70)
                                .background(
                                    selectedReaction == emoji
                                    ? Color(hex: "D2F1D9")
                                    : Color.white
                                )
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(
                                        selectedReaction == emoji
                                        ? Color(hex: "30D158")
                                        : Color.gray.opacity(0.3),
                                        lineWidth: 2
                                    )
                                )
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 3)
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden(true)   // ما نبي السهم الافتراضي
        // لا تحطين toolbar هنا عشان ما يطلع زر ثاني
    }
}

