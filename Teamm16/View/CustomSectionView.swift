import SwiftUI
import UIKit
import SwiftData

// MARK: - شاشة قسمي الخاص

struct CustomSectionView: View {


        @Environment(\.modelContext) private var modelContext
        @StateObject private var viewModel: CustomCardsViewModel
        @State private var isShowingAddCard = false

        init() {
            _viewModel = StateObject(wrappedValue: CustomCardsViewModel(context: ModelContext(try! ModelContainer(for: CustomCardEntity.self))))
        }


    var body: some View {
        ZStack {
            Color(hex: "FAF9F6").ignoresSafeArea()

            VStack(spacing: 24) {

                header

                if viewModel.cards.isEmpty {
                    Spacer()
                    Text("أضف بطاقاتك الخاصة 🌱")
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

                                        if let uiImage = UIImage(data: card.imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                                )
                                        }

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
        .onAppear {
            viewModel.fetchCards()
        }
        .sheet(isPresented: $isShowingAddCard) {
            AddCustomCardView { image, caption in
                viewModel.addCard(image: image, caption: caption)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.layoutDirection, .rightToLeft)
    }

    // MARK: - الهيدر

    private var header: some View {
        HStack(spacing: 12) {

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

            Text("قسمي الخاص")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(hex: "ADACFA"))
                .cornerRadius(22)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - شاشة إضافة كرت
//////////////////////////////////////////////////////////////////

struct AddCustomCardView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var selectedImage: UIImage?
    @State private var captionText = ""

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
                            .fill(selectedImage == nil ? Color(hex: "2DCB18").opacity(0.25) : .clear)
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
                                Text("أضف ملف الصورة")
                                    .font(.system(size: 20, design: .rounded))
                            }
                            .foregroundColor(Color(hex: "444444"))
                        }
                    }
                    .frame(width: 280, height: 280)
                }
                .confirmationDialog("اختر مصدر الصورة", isPresented: $showImagePickerOptions) {
                    Button("أخذ صورة") { showCamera = true }
                    Button("اختيار صورة") { showPhotoLibrary = true }
                    Button("إلغاء", role: .cancel) { }
                }

                TextField("اكتب التعبير هنا...", text: $captionText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 32)

                Spacer()

                Button("تم") {
                    if let image = selectedImage, !captionText.isEmpty {
                        onSave(image, captionText)
                        dismiss()
                    }
                }
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "FDE88D"))
                .cornerRadius(24)
                .padding(.horizontal, 40)
                .disabled(selectedImage == nil || captionText.isEmpty)
            }
            .padding(.top, 32)
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - شاشة التفاصيل (بدون إيموجي)
//////////////////////////////////////////////////////////////////

struct CustomCardDetailView: View {

    let card: CustomCardEntity
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(hex: "FAF9F6").ignoresSafeArea()

            VStack(spacing: 20) {

                Spacer()

                if let uiImage = UIImage(data: card.imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }

                Text(card.caption)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(hex: "FDE88D"))
                    .cornerRadius(20)

                Spacer()

                Button("تم") {
                    dismiss()
                }
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "FDE88D"))
                .cornerRadius(16)
                .padding(.horizontal, 40)
            }
        }
    }
}

//////////////////////////////////////////////////////////////////
// MARK: - ImagePicker
//////////////////////////////////////////////////////////////////

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

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

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

//////////////////////////////////////////////////////////////////
// MARK: - Color Hex
//////////////////////////////////////////////////////////////////

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
