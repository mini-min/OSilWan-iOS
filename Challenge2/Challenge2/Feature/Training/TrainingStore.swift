//
//  TrainingStore.swift
//  Challenge2
//
//  Created by mini on 4/15/25.
//

import SwiftUI
import SwiftData

final class TrainingStore: ObservableObject {
    @Published private(set) var state = TrainingState()
    private let trainingType: TrainingType

    init(trainingType: TrainingType) {
        self.trainingType = trainingType
    }

    func send(_ action: TrainingAction) {
        switch action {
        case .incrementStep:
            if state.currentStep < 3 {
                state.currentStep += 1
            }
            
        case .decrementStep:
            if state.currentStep > 1 {
                state.currentStep -= 1
            }
            
        case .updateFailureText(let text):
            state.failureText = text
            
        case .updateNextText(let text):
            state.nextText = text
        }
    }
}
