import SwiftUI
import Combine

final class FoodViewModel: ObservableObject {

    struct FoodCard: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }

    @Published var cards: [FoodCard] = [
        FoodCard(title: "شوكولاتة", imageName: "chocolate"),
        FoodCard(title: "موية", imageName: "water"),
        FoodCard(title: "بطاطس", imageName: "fries"),
        FoodCard(title: "حليب", imageName: "milk"),
        FoodCard(title: "معكرونة", imageName: "pasta"),
        FoodCard(title: "شطيرة", imageName: "sandwich")
    ]
}
