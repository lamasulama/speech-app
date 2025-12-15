
import SwiftUI

struct DailySkillDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: DailySkillDetailViewModel
    
    init(card: DailySkillsViewModel.SkillCard) {
        _viewModel = StateObject(
            wrappedValue: DailySkillDetailViewModel(card: card)
        )
    }
    
    // 🔵 لون الكرت الجديد (baby blue نفس اللي في grid)
    private let cardBackground = Color(red: 0.90, green: 0.94, blue: 1.0)
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // زر رجوع بسيط
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(radius: 2)
                            )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                
                // الكرت الكبير (baby blue)
                VStack {
                    Image(viewModel.card.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                }
                .frame(maxWidth: .infinity, maxHeight: 360)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(cardBackground)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1.2)
                )
                .padding(.horizontal, 24)
                
                // العنوان (يبقى أصفر مثل ما هو)
                Text(viewModel.card.title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.98, green: 0.82, blue: 0.34))
                            .shadow(radius: 3)
                    )
                    .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct DailySkillDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let dummy = DailySkillsViewModel.SkillCard(
                title: "أبي أروح الحمام",
                imageName: "skill_bathroom"
            )
            NavigationStack {
                DailySkillDetailView(card: dummy)
            }
        }
    }
}

