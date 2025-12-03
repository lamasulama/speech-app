//
//  InsideCategoryViewModel.swift
//  team16
//
//  Created by lama bin slmah on 02/12/2025.
//
import Combine
import SwiftUI   // <-- important

final class InsideCategoryViewModel: ObservableObject {

    // The two options that should appear (boy / girl)
    let children: [ChildGender] = ChildGender.allCases

    // Parent decides what happens after selection (navigation)
    var onChildSelected: ((ChildGender) -> Void)?

    func didTap(child: ChildGender) {
        onChildSelected?(child)
    }
}

