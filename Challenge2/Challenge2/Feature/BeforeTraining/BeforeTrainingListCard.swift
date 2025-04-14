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
        HStack(spacing: 10) {
            Image(ImageLiterals.test.rawValue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(trainingType.title)
                    .font(.headline)
                    .foregroundStyle(.osWblack)
                
                Text(trainingType.description)
                    .font(.caption)
                    .foregroundStyle(.oswGray1)

            }
        }
        .frame(height: 100)
        .background(.oswGray3)
        .cornerRadius(20)
    }
}

#Preview {
    BeforeTrainingListCard(trainingType: .shoutFail)
}
