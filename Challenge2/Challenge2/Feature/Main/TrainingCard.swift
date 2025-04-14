//
//  TrainingCard.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingCard: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(.osWblack)
            Image(.test)
        }
        .frame(width: 105, height: 150)
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 20)
    }
}

#Preview {
    TrainingCard(title: "Learning\nTraning")
}
