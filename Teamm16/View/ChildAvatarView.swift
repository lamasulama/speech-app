//
//  ChildAvatarView.swift
//  team16
//
//  Created by lama bin slmah on 02/12/2025.
//
import SwiftUI

struct ChildAvatarView: View {
    let gender: ChildGender
    var diameter: CGFloat = 260

    private var backgroundColor: Color {
        switch gender {
        case .boy:
            return Color(red: 0.75, green: 0.87, blue: 1.0)   // light blue
        case .girl:
            return Color(red: 1.0, green: 0.82, blue: 0.88)   // light pink
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: diameter, height: diameter)

            Image(gender.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: diameter * 0.82, height: diameter * 0.82)
        }
    }
}
