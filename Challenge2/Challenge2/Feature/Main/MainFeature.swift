//
//  MainFeature.swift
//  Challenge2
//
//  Created by mini on 4/23/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State: Equatable {
        var currentMessage: String = MainCheerMessage.motivation1.rawValue
        var currentFrame = 0
        var isAnimating = false
    }
    
    enum Action: Equatable {
        case onAppear
        case animationStart
        case animationTick
        case changeRandomMessage
    }
    
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.currentFrame = 0
                return .none
                
            case .animationStart:
                guard state.isAnimating == false else { return .none }
                state.isAnimating = true
                state.currentFrame = 0

                return .run { send in
                    for _ in 0..<13 {
                        try await clock.sleep(for: .milliseconds(77))
                        await send(.animationTick)
                    }
                }
                
            case .animationTick:
                guard state.currentFrame < 12 else {
                    state.isAnimating = false
                    return .none
                }
                state.currentFrame += 1
                return .none

            case .changeRandomMessage:
                let newMessage = MainCheerMessage.allCases
                    .filter { $0.rawValue != state.currentMessage }
                    .randomElement()?.rawValue ?? state.currentMessage
                state.currentMessage = newMessage
                return .none
            }
        }
    }
}
