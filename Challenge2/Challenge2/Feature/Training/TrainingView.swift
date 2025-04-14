//
//  TrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingView: View {
    @State private var currentStep: Int = 1
    let trainingType: TrainingType

    var body: some View {
        VStack {
            OSWProgressBar(totalSteps: 3, currentStep: $currentStep)
            
            HStack(spacing: 12) {
                OSWButton(
                    style: .secondary,
                    size: .half,
                    title: "이전",
                    action: {
                        currentStep -= 1
                    }
                )
                
                OSWButton(
                    style: .active,
                    size: .half,
                    title: "다음",
                    action: {
                        currentStep += 1
                    }
                )
            }
        }
    }
}

#Preview {
    TrainingView(trainingType: .learning)
}
