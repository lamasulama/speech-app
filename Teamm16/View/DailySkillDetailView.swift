//
//  DailySkillDetailView.swift
//  Teamm16
//
//  Created by lama bin slmah on 03/12/2025.
//


import SwiftUI

struct DailySkillDetailView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: DailySkillDetailViewModel

    init(card: DailySkillsViewModel.SkillCard) {
        _viewModel = StateObject(
            wrappedValue: DailySkillDetailViewModel(card: card)
        )
    }

    private let cardBackground = Color(red: 1.0, green: 0.98, blue: 0.91)

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 24) {

                // زر رجوع بسيط
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

                // الكرت الكبير
                VStack {
                    Image(viewModel.card.imageName)
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

                // العنوان
                Text(viewModel.card.title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.98, green: 0.82, blue: 0.34))
                            .shadow(radius: 3)
                    )
                    .padding(.horizontal, 40)

                Spacer()

                // سطر الإيموجي (نفس المشاعر)
                reactionRow
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Show card")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var reactionRow: some View {
        HStack(spacing: 18) {
            ForEach(EmotionReaction.allCases) { reaction in
                Button {
                    viewModel.select(reaction)
                } label: {
                    Circle()
                        .fill(backgroundColor(for: reaction))
                        .frame(width: 56, height: 56)
                        .overlay(
                            Text(reaction.emoji)
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

    private func backgroundColor(for reaction: EmotionReaction) -> Color {
        if viewModel.selectedReaction == reaction {
            return Color.green.opacity(0.2)   // الهايلايت الأخضر
        } else {
            return Color.white
        }
    }
}

struct DailySkillDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dummy = DailySkillsViewModel.SkillCard(
            title: "أبي أروح الحمام",
            imageName: "skill_bathroom"
        )
        NavigationStack {
            DailySkillDetailView(card: dummy)
        }
    }
}
