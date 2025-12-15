import SwiftUI
import SwiftData
import UIKit
import Combine

@MainActor
final class CustomCardsViewModel: ObservableObject {
    @Published var cards: [CustomCardEntity] = []

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchCards()
    }

    func fetchCards() {
        let descriptor = FetchDescriptor<CustomCardEntity>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        do {
            cards = try context.fetch(descriptor)
        } catch {
            cards = []
            print("❌ Fetch error:", error)
        }
    }

    func addCard(image: UIImage, caption: String) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let newCard = CustomCardEntity(caption: caption, imageData: data)
        context.insert(newCard)
        fetchCards()
    }

    func deleteCard(_ card: CustomCardEntity) {
        context.delete(card)
        fetchCards()
    }
}


