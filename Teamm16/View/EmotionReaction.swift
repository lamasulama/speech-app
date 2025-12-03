import Combine
import SwiftUI

// MARK: - Reaction type (👎 👍 ❤️ 🙂)

enum EmotionReaction: String, CaseIterable, Identifiable {
    case dislike
    case like
    case love
    case happy

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .dislike: return "👎"
        case .like:    return "👍"
        case .love:    return "❤️"
        case .happy:   return "😊"
        }
    }
}

// MARK: - ViewModel

final class EmotionDetailViewModel: ObservableObject {

    let card: EmotionsViewModel.EmotionCard
    let gender: ChildGender

    @Published var selectedReaction: EmotionReaction? = nil

    init(card: EmotionsViewModel.EmotionCard, gender: ChildGender) {
        self.card = card
        self.gender = gender
    }

    func select(_ reaction: EmotionReaction) {
        selectedReaction = reaction
    }
}

// MARK: - VIEW

struct EmotionDetailView: View {

    @StateObject private var viewModel: EmotionDetailViewModel
    @Environment(\.dismiss) var dismiss

    init(card: EmotionsViewModel.EmotionCard, gender: ChildGender) {
        _viewModel = StateObject(
            wrappedValue: EmotionDetailViewModel(card: card, gender: gender)
        )
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 24) {

                // ❗️هنا كان HStack فيه "تم" والسهم – شلّيناه
                // لو تبين رجعينه أو نغير النص، هذا هو المكان

                Spacer().frame(height: 8) // مسافة بسيطة بدل الـ HStack

                // الكرت الكبير مع الصورة
                VStack {
                    Image(viewModel.card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                }
                .frame(maxWidth: .infinity, minHeight: 260)
                .background(Color(red: 1.0, green: 0.98, blue: 0.92))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.black.opacity(0.15), lineWidth: 1.5)
                )
                .cornerRadius(24)
                .padding(.horizontal, 24)

                // العنوان الأصفر
                Text(viewModel.card.title)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.98, green: 0.82, blue: 0.34))
                            .shadow(radius: 4, y: 2)
                    )
                    .padding(.horizontal, 40)

                Spacer()

                // صف الإيموجيز
                reactionRow
                    .padding(.bottom, 32)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Reaction row

    private var reactionRow: some View {
        HStack(spacing: 18) {

            ForEach(EmotionReaction.allCases) { reaction in
                Button {
                    viewModel.select(reaction)
                } label: {
                    Circle()
                        .strokeBorder(borderColor(for: reaction), lineWidth: 2)
                        .background(
                            Circle()
                                .fill(highlightColor(for: reaction))
                        )
                        .frame(width: 60, height: 60)
                        .overlay(
                            Text(reaction.emoji)
                                .font(.system(size: 28))
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
        )
        .padding(.horizontal, 24)
    }

    private func highlightColor(for reaction: EmotionReaction) -> Color {
        if viewModel.selectedReaction == reaction {
            return Color(red: 0.87, green: 0.98, blue: 0.89) // أخضر فاتح
        } else {
            return Color.white
        }
    }

    private func borderColor(for reaction: EmotionReaction) -> Color {
        if viewModel.selectedReaction == reaction {
            return Color(red: 0.40, green: 0.80, blue: 0.45) // إطار أخضر
        } else {
            return Color.black.opacity(0.12)
        }
    }
}

// MARK: - Preview

struct EmotionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let dummy = EmotionsViewModel.EmotionCard(
                title: "فرحان",
                imageName: "boy_happy"
            )
            EmotionDetailView(card: dummy, gender: .boy)
        }
    }
}
