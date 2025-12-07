


import SwiftUI
import Combine

final class FoodViewModel: ObservableObject {

    struct FoodCard: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    @Published var cards: [FoodCard] = [
        FoodCard(title: "اكل",        imageName: "food_eat"),
        FoodCard(title: "اشرب",      imageName: "food_drink"),
        FoodCard(title: " سناك",      imageName: "food_snack"),
        FoodCard(title: " حلويات",    imageName: "food_dessert"),
        FoodCard(title: "جوعان",         imageName: "food_hungry"),
        FoodCard(title: "شبعان",         imageName: "food_full")
    ]
}
