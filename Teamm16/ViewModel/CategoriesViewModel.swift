import Combine
import SwiftUI

final class CategoriesViewModel: ObservableObject {
    
    @Published var gender: ChildGender
    
    let categories: [CategoryItem]
    
    init(gender: ChildGender) {
        self.gender = gender
        
        categories = [
            CategoryItem(
                title: "مشاعري",
                iconName: "emotionsIcon",
                backgroundColor: Color(red: 0.98, green: 0.82, blue: 0.34),
                kind: .emotions
            ),
            CategoryItem(
                title: "الحياة اليومية",
                iconName: "dailySkillsIcon",
                backgroundColor: Color(red: 0.61, green: 0.80, blue: 1.0),
                kind: .dailySkills
            ),
            CategoryItem(
                title: "الطعام",
                iconName: "foodIcon",
                backgroundColor: Color(red: 0.95, green: 0.52, blue: 0.40),
                kind: .food
            ),
            CategoryItem(
                title: "قسمي الخاص",
                iconName: "starIcon",
                backgroundColor: Color(red: 0.74, green: 0.70, blue: 1.0),
                kind: .custom
            )
        ]
    }
    
    // MARK: - Category selection
    
    func didSelectCategory(_ item: CategoryItem) {
        // حالياً بس نطبع الاختيار (للتجربة)
        // التصفح نفسه يصير من خلال NavigationLink في الـ View
        print("Selected category: \(item.title)")
        
        // لو حبيتي بعدين تربطينه بتنقّل ثاني أو logic إضافي
        // تقدرين تكتبين الكود هنا.
    }
}
