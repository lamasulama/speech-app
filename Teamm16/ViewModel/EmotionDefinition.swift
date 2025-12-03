import Combine
import SwiftUI

// MARK: - Helper model used only inside the view model
struct EmotionDefinition {
    let boyTitle: String
    let girlTitle: String
    let boyImageName: String
    let girlImageName: String
}

final class EmotionsViewModel: ObservableObject {

    struct EmotionCard: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    @Published var cards: [EmotionCard] = []
    let gender: ChildGender

    init(gender: ChildGender) {
        self.gender = gender
        loadCards()
    }

    private func loadCards() {

        // TODO: change image names to match your Assets.xcassets
        let base: [EmotionDefinition] = [
            EmotionDefinition(
                boyTitle: "فرحان",
                girlTitle: "فرحانة",
                boyImageName: "boy_happy",
                girlImageName: "girl_happy"
            ),
            EmotionDefinition(
                boyTitle: "خايف",
                girlTitle: "خايفة",
                boyImageName: "boy_scared",
                girlImageName: "girl_scared"
            ),
            EmotionDefinition(
                boyTitle: "زعلان",
                girlTitle: "زعلانة",
                boyImageName: "boy_sad",
                girlImageName: "girl_sad"
            ),
            EmotionDefinition(
                boyTitle: "معصب",
                girlTitle: "معصبة",
                boyImageName: "boy_angry",
                girlImageName: "girl_angry"
            ),
            EmotionDefinition(
                boyTitle: "تعبان",
                girlTitle: "تعبانة",
                boyImageName: "boy_tired",
                girlImageName: "girl_tired"
            ),
            EmotionDefinition(
                boyTitle: "طفشان",
                girlTitle: "طفشانة",
                boyImageName: "boy_bored",
                girlImageName: "girl_bored"
            )
        ]

        cards = base.map { def in
            switch gender {
            case .boy:
                return EmotionCard(title: def.boyTitle, imageName: def.boyImageName)
            case .girl:
                return EmotionCard(title: def.girlTitle, imageName: def.girlImageName)
            }
        }
    }
}
