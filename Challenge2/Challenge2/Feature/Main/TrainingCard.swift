//
//  TrainingCard.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingCard: View {
    private let type: TrainingType
    
    init(type: TrainingType) {
        self.type = type
    }
    
    var body: some View {
        VStack {
            Text(type.title)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.osWblack)
                .padding(.top, 10)
            Image(type.imageName)
                .resizable()
                .scaledToFit()
                .padding(5)
        }
        .frame(width: 110, height: 180)
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 20)
    }
}

#Preview {
    TrainingCard(type: .goal)
}
