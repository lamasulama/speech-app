//
//  DailySkillsViewModel.swift
//  Teamm16
//
//  Created by lama bin slmah on 03/12/2025.
//


import Foundation
import SwiftUI
import Combine

final class DailySkillsViewModel: ObservableObject {
    // MARK: - ViewModel

    @MainActor
    class DailySkillDetailViewModel: ObservableObject {
        
        @Published var card: DailySkillsViewModel.SkillCard
        
        init(card: DailySkillsViewModel.SkillCard) {
            self.card = card
        }
    }


    struct SkillCard: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    @Published var cards: [SkillCard] = []

    init() {
        loadCards()
    }

    private func loadCards() {
        cards = [
            SkillCard(title: " الحمام",   imageName: "skill_bathroom"),
            SkillCard(title: " انام",          imageName: "skill_sleep"),
            SkillCard(title: " البس",          imageName: "skill_dress"),
            SkillCard(title: " العب",          imageName: "skill_play"),
            SkillCard(title: "اهلي", imageName: "skill_parents"),
            SkillCard(title: " مساعده",        imageName: "skill_help")
        ]
    }
}
