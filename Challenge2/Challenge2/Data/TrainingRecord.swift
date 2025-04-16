//
//  TrainingRecord.swift
//  Challenge2
//
//  Created by mini on 4/15/25.
//

import Foundation
import SwiftData

@Model
final class TrainingRecord {
    @Attribute(.unique) var id: UUID
    var trainingType: String
    var failureText: String
    var nextText: String
    var savedDate: Date

    init(
        trainingType: String,
        failureText: String,
        nextText: String,
        savedDate: Date = Date()
    ) {
        self.id = UUID()
        self.trainingType = trainingType
        self.failureText = failureText
        self.nextText = nextText
        self.savedDate = savedDate
    }
}

extension TrainingRecord {
    var trainingTypeEnum: TrainingType {
        return TrainingType(rawValue: trainingType) ?? .learning
    }
}
