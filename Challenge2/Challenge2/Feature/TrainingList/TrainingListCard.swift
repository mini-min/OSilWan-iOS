//
//  TrainingListCard.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

struct TrainingListCard: View {
    let imageName: String
    let date: String
    let contents: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 85, height: 85)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(date)의 실패 트레이닝")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(.osWblack)
                Text(contents)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.oswGray1)
            }
        }
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 20)
    }
}

#Preview {
    TrainingListCard(
        imageName: ImageLiterals.test.rawValue,
        date: "04.11의 실패 트레이닝",
        contents: "오늘 아침에 일찍 일어나기를 실패해버리다..\n그럼에도 불구하고. 어쩌구 저쩌구....."
    )
}
