//
//  Teamm16App.swift
//  Teamm16
//
//  Created by lama bin slmah on 02/12/2025.
//

import SwiftUI
import SwiftData


@main
struct Teamm16App: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                InsideCategoryView()
            }
        }
        .modelContainer(for: CustomCardEntity.self)
    }
}

