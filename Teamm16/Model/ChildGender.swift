import Foundation

enum ChildGender: String, CaseIterable, Identifiable, Hashable {
    case boy
    case girl

    var id: String { rawValue }

    // this is the image WITHOUT a background (transparent)
    var imageName: String {
        switch self {
        case .boy:  return "boyAvatar"   // name of your PNG
        case .girl: return "girlAvatar"
        }
    }
}
