//
//  MainView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct MainView: View {
    
    // MARK: - Properties
    
    let store: StoreOf<MainFeature>
    
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("shouldAnimate") private var shouldAnimate: Bool = false
    @Query private var records: [TrainingRecord]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea(.all)
            
            VStack {
                HeaderMessageSection(
                    recordCount: records.count,
                    onPush: { type in
                        coordinator.push(.beforeTraining(trainingType: type))
                    }
                )
                
                Spacer()
                
                AnimationSection(
                    currentMessage: store.state.currentMessage,
                    currentFrame: store.state.currentFrame
                ) {
                    store.send(.animationStart)
                    store.send(.changeRandomMessage)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(.trainingList)
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .padding(.top, 16)
                        .padding(.trailing, 8)
                }
            }
        }
        .onAppear { store.send(.onAppear) }
        .onChange(of: shouldAnimate) {
            if shouldAnimate {
                store.send(.animationStart)
                shouldAnimate = false
            }
        }
    }
    
    // MARK: - [SubViews] Header Message Section
    
    struct HeaderMessageSection: View {
        private(set) var recordCount: Int
        private(set) var onPush: (TrainingType) -> Void
        
        var body: some View {
            Text.styledText(
                fullText: "지금까지 \(recordCount)개의 \n실패 트레이닝을 완료했어요!",
                highlightedText: "\(recordCount)",
                baseFont: .title3.weight(.heavy),
                highlightedFont: .title2.weight(.heavy)
            )
            .lineSpacing(5)
            .frame(width: 350, alignment: .leading)
            .padding(.top, 12)
            .padding(.bottom, 28)
            
            HStack(spacing: 12) {
                ForEach(TrainingType.allCases, id: \.self) { type in
                    Button {
                        onPush(type)
                    } label: {
                        TrainingCard(type: type)
                    }
                }
            }
        }
    }
    
    // MARK: - [SubViews] Training Card
    
    struct TrainingCard: View {
        private(set) var type: TrainingType
        
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
    
    // MARK: - [SubViews] Training Card
    
    struct AnimationSection: View {
        private(set) var currentMessage: String
        private(set) var currentFrame: Int
        private(set) var onCharacterTap: () -> Void
        
        var body: some View {
            VStack(spacing: 10) {
                ZStack {
                    Image(.speechBubble)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)
                    
                    Text(currentMessage)
                        .font(.system(size: 12, weight: .bold))
                        .lineSpacing(8)
                        .foregroundColor(.sub)
                        .padding(.bottom, 40)
                }
                Image("\(currentFrame + 1)")
                    .onTapGesture { onCharacterTap() }
            }
            .padding(.bottom, 40)
        }
    }
}
