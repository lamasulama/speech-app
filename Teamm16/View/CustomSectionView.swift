import SwiftUI
import UIKit

// MARK: - شاشة قسمي الخاص

struct CustomSectionView: View {
    @StateObject private var viewModel = CustomCardsViewModel()
    @State private var isShowingAddCard = false

    var body: some View {
        ZStack {
            Color(hex: "FAF9F6").ignoresSafeArea()

            VStack(spacing: 24) {

                header

                if viewModel.cards.isEmpty {
                    Spacer()
                    Text("أضف بطاقاتك الخاصة فيك ;)")
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundColor(Color(hex: "756B6B"))
                        .multilineTextAlignment(.center)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible())],
                            spacing: 20
                        ) {
                            ForEach(viewModel.cards) { card in
                                NavigationLink {
                                    CustomCardDetailView(card: card)
                                } label: {
                                    VStack(spacing: 8) {
                                        Image(uiImage: card.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                            )

                                        Text(card.caption)
                                            .font(.system(size: 20, design: .rounded))
                                            .foregroundColor(Color(hex: "444444"))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 6)
                                            .background(Color(hex: "ADACFA").opacity(0.3))
                                            .cornerRadius(10)
                                    }
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(24)
                                    .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddCard) {
            AddCustomCardView { image, caption in
                viewModel.addCard(image: image, caption: caption)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")   // نخلي العنوان فاضي لأن عندنا كبسولة العنوان تحت
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }

    // MARK: - الهيدر

    private var header: some View {
        HStack(spacing: 12) {
            // زر +
            Button {
                isShowingAddCard = true
            } label: {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                    )
            }

            // المستطيل البنفسجي (العنوان)
            Text("قسمي الخاص")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(hex: "ADACFA"))
                .cornerRadius(22)

            // ما فيه زر سهم هنا – زر الرجوع بس حق الـ Navigation فوق
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
}

// MARK: - شاشة إضافة كرت

struct AddCustomCardView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedImage: UIImage? = nil
    @State private var captionText: String = ""

    @State private var showImagePickerOptions = false
    @State private var showCamera = false
    @State private var showPhotoLibrary = false

    let onSave: (UIImage, String) -> Void

    var body: some View {
        ZStack {
            Color(hex: "FAF9F6").ignoresSafeArea()

            VStack(spacing: 30) {

                Button {
                    showImagePickerOptions = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(selectedImage == nil ? Color(hex: "2DCB18").opacity(0.25) : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(hex: "0FA618"), lineWidth: 2)
                            )

                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        } else {
                            VStack(spacing: 12) {
                                Image(systemName: "paperclip")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color(hex: "444444"))

                                Text("أضف ملف الصورة")
                                    .font(.system(size: 20, design: .rounded))
                                    .foregroundColor(Color(hex: "444444"))
                            }
                        }
                    }
                    .frame(width: 280, height: 280)
                }
                .confirmationDialog("اختر مصدر الصورة", isPresented: $showImagePickerOptions) {
                    Button("أخذ صورة") { showCamera = true }
                    Button("اختيار صورة") { showPhotoLibrary = true }
                    Button("إلغاء", role: .cancel) { }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("تعبير للصورة")
                        .font(.headline)
                        .foregroundColor(Color(hex: "756B6B"))

                    TextField("اكتب هنا...", text: $captionText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 32)

                Spacer()

                Button {
                    if let img = selectedImage, !captionText.isEmpty {
                        onSave(img, captionText)
                        dismiss()
                    }
                } label: {
                    Text("تم")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(hex: "FDE88D"))
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal, 40)
                        .padding(.bottom, 24)
                }
                .disabled(selectedImage == nil || captionText.isEmpty)
                .opacity((selectedImage == nil || captionText.isEmpty) ? 0.5 : 1)
            }
            .padding(.top, 32)
        }
        .navigationTitle("إضافة")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: "444444"))
                }
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
    }
}

// MARK: - شاشة التفاصيل

struct CustomCardDetailView: View {
    let card: CustomCardItem
    @Environment(\.dismiss) private var dismiss
    @State private var selectedReaction: String? = nil

    private let emojis = ["👎", "👍", "❤️", "😊"]

    var body: some View {
        ZStack {
            Color(hex: "FAF9F6").ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 0) {
                    Image(uiImage: card.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 320)
                        .clipped()
                        .background(Color(hex: "FFF8E1"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                        )
                        .cornerRadius(24)

                    Text(card.caption)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 320)
                        .padding()
                        .background(Color(hex: "FDE88D"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                        )
                        .padding(.top, 12)
                }

                Spacer()

                HStack(spacing: 18) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button {
                            selectedReaction = emoji
                        } label: {
                            Text(emoji)
                                .font(.system(size: 34))
                                .frame(width: 70, height: 70)
                                .background(
                                    selectedReaction == emoji
                                    ? Color(hex: "D2F1D9")
                                    : Color.white
                                )
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(
                                        selectedReaction == emoji
                                        ? Color(hex: "30D158")
                                        : Color.gray.opacity(0.3),
                                        lineWidth: 2
                                    )
                                )
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(24)
                .shadow(radius: 3)
                .padding(.horizontal, 24)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("تم")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "FDE88D"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: "444444"))
                }
            }
        }
    }
}

// MARK: - ImagePicker

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Color hex (تأكدي ما فيه نسخة ثانية بنفس الاسم)

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(.sRGB,
                  red:   Double(r) / 255,
                  green: Double(g) / 255,
                  blue:  Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
