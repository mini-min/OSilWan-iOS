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
                .opacity(0.9)
        }
        .frame(width: 110, height: 180)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .oswGray1.opacity(0.4), radius: 20, x: 0, y: 5)
    }
}

#Preview {
    TrainingCard(type: .goal)
}
