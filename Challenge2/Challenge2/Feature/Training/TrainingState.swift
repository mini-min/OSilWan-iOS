//
//  TrainingState.swift
//  Challenge2
//
//  Created by mini on 4/15/25.
//

import SwiftUI

struct TrainingState {
    var currentStep: Int = 1
    var failureText = ""
    var nextText = ""
    
    var isNextButtonDisabled: Bool {
        switch currentStep {
        case 1:
            return failureText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case 2:
            return nextText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        default:
            return false
        }
    }
}
