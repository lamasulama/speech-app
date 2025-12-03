//
//  ChildAvatarView.swift
//  team16
//
//  Created by lama bin slmah on 02/12/2025.
//

import SwiftUI

struct ChildAvatarView: View {
    let gender: ChildGender
    var diameter: CGFloat = 260       // default for the big screen

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.78, green: 0.95, blue: 0.78))   // light green
                .frame(width: diameter, height: diameter)

            Image(gender.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: diameter * 0.82, height: diameter * 0.82)
        }
    }
}
