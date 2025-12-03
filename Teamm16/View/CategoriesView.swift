import SwiftUI

struct CategoriesView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CategoriesViewModel

    init(gender: ChildGender) {
        _viewModel = StateObject(wrappedValue: CategoriesViewModel(gender: gender))
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .padding(40)
                        .overlay(
                            VStack(alignment: .trailing, spacing: 80) {

                                // HEADER (avatar + greeting)
                                HStack {
                                    // الأفاتار زر رجوع
                                    Button {
                                        dismiss()
                                    } label: {
                                        ChildAvatarView(
                                            gender: viewModel.gender,
                                            diameter: 70
                                        )
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("مرحباً بك،")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)

                                        Text("الأقسام")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }

                                // CATEGORY BUTTONS
                                VStack(spacing: 22) {
                                    ForEach(viewModel.categories) { item in
                                        NavigationLink {
                                            destinationView(for: item)   // 👈 هنا التنقّل
                                        } label: {
                                            CategoryButtonView(item: item)
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
        .navigationBarBackButtonHidden(true)   // نخفي السهم هنا بس
    }

    // MARK: - Destination for each category

    @ViewBuilder
    private func destinationView(for item: CategoryItem) -> some View {
        switch item.kind {
        case .emotions:
            // صفحة المشاعر
            EmotionsView(gender: viewModel.gender)

        case .dailySkills:
            DailySkillsView()
        case .food:
            Text("الطعام (لاحقاً)") // مؤقتاً

        case .custom:
            CustomSectionView()
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoriesView(gender: .girl)
        }
        .previewLayout(.sizeThatFits)
    }
}
