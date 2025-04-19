//
//  TrainingListCard.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

struct BeforeTrainingListCard: View {
    let trainingType: DetailTrainingType

    var body: some View {
        HStack(spacing: 5) {
            Image(trainingType.iconName)
                .padding(20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(trainingType.title)
                    .font(.headline)
                    .foregroundStyle(.osWblack)
                
                Text(trainingType.description)
                    .font(.caption)
                    .foregroundStyle(.oswGray1)
                    .lineLimit(2)
                    .frame(width: 264, alignment: .leading)
            }
        }
        .frame(height: 100)
        .background(.oswGray3)
        .cornerRadius(20)
    }
}

#Preview {
    BeforeTrainingListCard(trainingType: .shoutFail)
    BeforeTrainingListCard(trainingType: .writeEmpathy)
    BeforeTrainingListCard(trainingType: .writeFail)
    BeforeTrainingListCard(trainingType: .writeGoal)
    BeforeTrainingListCard(trainingType: .writeLearn)
}
