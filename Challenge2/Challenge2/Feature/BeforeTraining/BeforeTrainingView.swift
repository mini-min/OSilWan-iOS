//
//  BeforeTrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct BeforeTrainingView: View {
    @State private var isTrainingStarted: Bool = false
    let trainingType: TrainingType
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        Text(trainingType.tite)
                        Text(trainingType.description)
                    }
                    
                    trainingType.image
                }
                
                ForEach(TrainingType.allCases, id: \.self) { type in
                    TrainingListCard(trainingType: type.trainingList[0])
                }
                
                OSWButton(
                    style: .active,
                    size: .full,
                    title: "트레이닝 시작하기",
                    action: {
                        isTrainingStarted = true
                    }
                )
            }
            .navigationDestination(
                isPresented: $isTrainingStarted,
                destination: { TrainingView(trainingType: trainingType)
                }
            )
        }
    }
}

#Preview {
    BeforeTrainingView(trainingType: .learning)
}
