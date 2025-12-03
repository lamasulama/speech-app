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
            SkillCard(title: "أبي أروح الحمام",   imageName: "skill_bathroom"),
            SkillCard(title: "أبي أنام",          imageName: "skill_sleep"),
            SkillCard(title: "أبي ألبس",          imageName: "skill_dress"),
            SkillCard(title: "أبي ألعب",          imageName: "skill_play"),
            SkillCard(title: "أبي أشوف أمي / أبوي", imageName: "skill_parents"),
            SkillCard(title: "أبي مساعده",        imageName: "skill_help")
        ]
    }
}
