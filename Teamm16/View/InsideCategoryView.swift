import SwiftUI

struct InsideCategoryView: View {

    @StateObject var viewModel: InsideCategoryViewModel

    init(viewModel: InsideCategoryViewModel = InsideCategoryViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Spacer()

            // Boy
            NavigationLink(value: ChildGender.boy) {
                ChildAvatarView(gender: .boy)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()

            // Girl
            NavigationLink(value: ChildGender.girl) {
                ChildAvatarView(gender: .girl)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationTitle("اختر الجنس الخاص بك ")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: ChildGender.self) { gender in
            CategoriesView(gender: gender)
        }
    }
}
