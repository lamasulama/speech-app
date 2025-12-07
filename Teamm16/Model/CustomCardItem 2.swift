import UIKit

struct CustomCardItem: Identifiable, Equatable {
    let id = UUID()
    var image: UIImage
    var caption: String
}
