
import SwiftUI

struct DailySkillsView: View {

    @StateObject private var viewModel = DailySkillsViewModel()

    // نفس أعمدة EmotionsView
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 16) {

                // الكبسولة الزرقاء العلوية (نفس فكرة المشاعر بس بلون الأزرق)
                HStack {
                    Spacer()

                    Capsule()
                        .fill(Color(red: 0.61, green: 0.80, blue: 1.0))
                        .frame(height: 40)
                        .overlay(
                            Text("الحياة اليومية")
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
                                DailySkillDetailView(card: card)
                            } label: {
                                skillCardView(card)
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

    // الكرت – نفس مقاسات EmotionsView بالضبط
    private func skillCardView(_ card: DailySkillsViewModel.SkillCard) -> some View {
        VStack(spacing: 8) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)          // نفس ارتفاع صورة المشاعر

            Text(card.title)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 140)   // نفس ارتفاع الكرت بالمشاعر
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.90, green: 0.94, blue: 1.0))   // أزرق فاتح
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
        )
        .cornerRadius(16)
    }
}

struct DailySkillsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DailySkillsView()
        }
    }
}
