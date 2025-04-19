//
//  MainView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var currentMessage: String = StringLiterals.MainMessage.motivation1.rawValue
    @Query private var records: [TrainingRecord]
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea(.all)
            
            VStack {
                HStack(spacing: 12) {
                    ForEach(TrainingType.allCases, id: \.self) { type in
                        Button {
                            coordinator.push(.beforeTraining(trainingType: type))
                        } label: {
                            TrainingCard(type: type)
                        }
                    }
                }
                .padding(.top, 30)
                
                Text("지금까지 \(records.count)개의 트레이닝을 완료했어요!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .frame(width: 350, alignment: .leading)
                
                MainBottomView(currentMessage: $currentMessage)
                    .padding(.top, 10)
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(.trainingList)
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .padding(.top, 16)
                        .padding(.trailing, 8)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Image(.mainLogo)
                    .padding(.top, 16)
                    .padding(.leading, 8)
            }
        }
    }
}
