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
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(trainingType.title)
                    .font(.title)
                    .fontWeight(.heavy)
                Text(trainingType.description)
                    .font(.callout)
                    .foregroundStyle(.oswGray1)
            }
            .padding(.top, 64)
            
            
            VStack(alignment: .leading, spacing: 12) {
                Text("트레이닝 리스트")
                    .font(.title3)
                    .fontWeight(.bold)
                
                ForEach(trainingType.trainingList, id: \.self) { training in
                    BeforeTrainingListCard(trainingType: training)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 64)
            
            
            Spacer()
            
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

#Preview {
    BeforeTrainingView(trainingType: .learning)
}
