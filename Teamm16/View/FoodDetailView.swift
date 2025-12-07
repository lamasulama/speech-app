import SwiftUI

struct FoodDetailView: View {

    let card: FoodViewModel.FoodCard
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedReaction: String? = nil
    
    // نفس الإيموجيز الخاصة بالمشاعر
    private let emojis = ["👎", "👍", "❤️", "😊"]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()

                // الصورة + النص
                VStack(spacing: 0) {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 320)
                        .clipped()
                        .background(Color(hex: "FFE6D5")) // peach
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                        )
                        .cornerRadius(20)

                    Text(card.title)
                        .font(.system(size: 40, weight: .bold))
                        .frame(maxWidth: 320)
                        .padding()
                        .background(Color(hex: "FFE6D5"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                        )
                        .padding(.top, 12)
                }

                Spacer()

                // الإيموجيز (ردود الفعل)
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
                                    ? Color(hex: "D2F1D9")  // أخضر فاتح عند التحديد
                                    : Color.white
                                )
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(
                                        selectedReaction == emoji
                                        ? Color(hex: "30D158")  // أخضر للحدود
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

                Spacer()

                // زر تم
                Button {
                    dismiss()
                } label: {
                    Text("تم")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "FDE88D")) // أصفر خفيف
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
