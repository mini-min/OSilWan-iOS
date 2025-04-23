//
//  BeforeTrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct BeforeTrainingView: View {
    
    // MARK: - Properties

    @EnvironmentObject private var coordinator: Coordinator
    private(set) var trainingType: TrainingType
    
    // MARK: - Body

    var body: some View {
        VStack {
            BeforeTrainingHeaderSection(trainingType: trainingType)
            
            BeforeTrainingListSection(trainingType: trainingType)
            
            Spacer()
            
            OSWButton(
                style: .active,
                size: .full,
                title: "트레이닝 시작하기",
                action: {
                    coordinator.push(.training(trainingType: trainingType))
                }
            )
        }
    }
    
    // MARK: - [SubViews] Before Training Header Section

    struct BeforeTrainingHeaderSection: View {
        private(set) var trainingType: TrainingType
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(trainingType.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    Text(trainingType.description)
                        .font(.callout)
                        .foregroundStyle(.oswGray1)
                        .lineSpacing(5)
                }
                .padding(.top, 32)
                .background(
                    Image(trainingType.imageName)
                        .padding(.leading, 300)
                        .opacity(0.5)
                )

                Spacer()
            }
            .padding(.leading, 24)
        }
    }
    
    // MARK: - [SubViews] Before Training List Section

    struct BeforeTrainingListSection: View {
        private(set) var trainingType: TrainingType

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("트레이닝 리스트")
                    .font(.title3)
                    .fontWeight(.bold)
                
                ForEach(trainingType.trainingList, id: \.self) { training in
                    BeforeTrainingListCard(trainingType: training)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 48)
        }
    }
    
    // MARK: - [SubViews] Before Training List Card

    struct BeforeTrainingListCard: View {
        private(set) var trainingType: DetailTrainingType

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
}
