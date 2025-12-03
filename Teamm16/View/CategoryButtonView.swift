import SwiftUI

struct CategoryButtonView: View {
    let item: CategoryItem

    var body: some View {
        HStack {
            // Text on the left (because Arabic reads right-to-left visually)
            Text(item.title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            Image(item.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 55)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(item.backgroundColor)
                .shadow(radius: 4, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.black.opacity(0.15), lineWidth: 1.5)
        )
    }
}
struct CategoryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonView(
            item: CategoryItem(
                title: "المشاعر والأحاسيس",
                iconName: "emotionsIcon",      // make sure this matches an asset name
                backgroundColor: Color(red: 0.98, green: 0.82, blue: 0.34),
                kind: .emotions
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
