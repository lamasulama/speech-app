//
//  CustomCardEntity.swift
//  Teamm16
//
//  Created by Shaima Alnasser on 13/12/2025.
//
import SwiftUI
import SwiftData
import UIKit

// MARK: - SwiftData Entity

@Model
final class CustomCardEntity {
    @Attribute(.unique) var id: UUID
    var caption: String
    var imageData: Data
    var createdAt: Date

    init(id: UUID = UUID(), caption: String, imageData: Data, createdAt: Date = Date()) {
        self.id = id
        self.caption = caption
        self.imageData = imageData
        self.createdAt = createdAt
    }
}
