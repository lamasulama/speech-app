//
//  CustomCardsViewModel.swift
//  Teamm16
//
//  Created by lama bin slmah on 03/12/2025.
//


import UIKit
import Combine

final class CustomCardsViewModel: ObservableObject {
    @Published var cards: [CustomCardItem] = []
    
    func addCard(image: UIImage, caption: String) {
        let new = CustomCardItem(image: image, caption: caption)
        cards.append(new)
    }
}
