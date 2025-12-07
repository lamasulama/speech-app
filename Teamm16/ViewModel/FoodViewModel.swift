import SwiftUI
import Combine

final class FoodViewModel: ObservableObject {

    struct FoodCard: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    @Published var cards: [FoodCard] = [
        FoodCard(title: "أبي آكل",        imageName: "food_eat"),
        FoodCard(title: "أبي أشرب",      imageName: "food_drink"),
        FoodCard(title: "أبي سناك",      imageName: "food_snack"),
        FoodCard(title: "أبي حلويات",    imageName: "food_dessert"),
        FoodCard(title: "جوعان",         imageName: "food_hungry"),
        FoodCard(title: "شبعان",         imageName: "food_full")
    ]
}
