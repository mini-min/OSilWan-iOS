//
//  TrainingListCard.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

struct TrainingListCard: View {
    @Binding var isEditMode: Bool
    let imageName: String
    let date: Date
    let contents: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Spacer(minLength: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(date.toMonthDayString)의 실패 트레이닝")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(.osWblack)
                Text(contents)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.oswGray1)
                    .lineSpacing(4)
            }
            .frame(minWidth: 234, alignment: .leading)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .frame(width: 343, height: 100)
        .background(.osWwhite)
        .cornerRadius(12)
    }
}

#Preview {
    TrainingListCard(
        isEditMode: .constant(true),
        imageName: ImageLiterals.test.rawValue,
        date: Date(),
        contents: "오늘 아침에 일찍 일어나기를 실패해버리다..\n그럼에도 불구하고. 어쩌구 저쩌구....."
    )
    
    TrainingListCard(
        isEditMode: .constant(true),
        imageName: ImageLiterals.test.rawValue,
        date: Date(),
        contents: "오늘 아침에 일찍 일어나기를 "
    )
}
