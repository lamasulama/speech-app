import SwiftUI

struct DailySkillsView: View {

    @StateObject private var viewModel = DailySkillsViewModel()

    // عمودين في كل صف
    private let columns = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing:40)
    ]

    var body: some View {
        ZStack {
            // الخلفية السوداء خلف الكرت
            Color.white.opacity(0.9)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack {
                    // الكرت الأبيض الكبير
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .padding(40)
                        .overlay(
                            VStack(spacing: 24) {

                                // الهيدر: + العنوان الأزرق + السهم
                                HStack(spacing: 16) {

                                    // زر +
                             

                                    Spacer()

                                    // عنوان الفئة
                                    Text("مهارات الحياة اليومية")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 24)
                                        .background(
                                            RoundedRectangle(cornerRadius: 26)
                                                .fill(Color(red: 0.61, green: 0.80, blue: 1.0))
                                        )

                                    // زر السهم (ما عليه أكشن حالياً)
                          
                                }

                                // شبكة الكروت
                                LazyVGrid(columns: columns, spacing: 24) {
                                    ForEach(viewModel.cards) { card in
                                        NavigationLink {
                                            DailySkillDetailView(card: card)
                                        } label: {
                                            skillCardView(card)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }

                                Spacer(minLength: 8)
                            }
                            .padding(24)
                        )
                        .padding(.horizontal, 16)
                        .padding(.top, 300)
                        .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        // مهم: لا نخبّي زر الرجوع هنا عشان تقدرين ترجعي
        // .navigationBarBackButtonHidden(false) // نقدر حتى ما نكتبها
    }

    // شكل الكرت الأزرق
    private func skillCardView(_ card: DailySkillsViewModel.SkillCard) -> some View {
        VStack(spacing: 8) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .padding(12)

            Text(card.title)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(Color(red: 0.90, green: 0.94, blue: 1.0))   // أزرق فاتح زي الصورة
        )
        .overlay(
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color.black.opacity(0.12), lineWidth: 1)
        )
    }
}

struct DailySkillsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DailySkillsView()
        }
    }
}
