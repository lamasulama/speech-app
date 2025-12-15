//
//  EmotionDetailView.swift
//  Teamm16
//
//  Created by Shaima Alnasser on 15/12/2025.
//
import Combine
import SwiftUI



struct EmotionDetailView: View {

    let card: EmotionsViewModel.EmotionCard
    let gender: ChildGender
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)

                    Text(card.title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(24)
                .frame(maxWidth: 300)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 1.0, green: 0.98, blue: 0.92))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.black.opacity(0.18), lineWidth: 1.5)
                )

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("تم")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.98, green: 0.82, blue: 0.34))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

