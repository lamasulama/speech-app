//
//  DailySkillDetailViewModel.swift
//  Teamm16
//
//  Created by lama bin slmah on 03/12/2025.
//


import Foundation
import SwiftUI
import Combine

final class DailySkillDetailViewModel: ObservableObject {

    let card: DailySkillsViewModel.SkillCard

    @Published var selectedReaction: EmotionReaction? = nil

    init(card: DailySkillsViewModel.SkillCard) {
        self.card = card
    }

    func select(_ reaction: EmotionReaction) {
        selectedReaction = reaction
    }
}
