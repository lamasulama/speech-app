import SwiftUI

enum CategoryKind {
    case emotions
    case dailySkills
    case food
    case custom
}

struct CategoryItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let iconName: String
    let backgroundColor: Color
    let kind: CategoryKind
}
