//
//  RootNavigationView.swift
//  Challenge2
//
//  Created by mini on 4/19/25.
//

import SwiftUI
import ComposableArchitecture

struct RootNavigationView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MainView(
                store: Store(initialState: MainFeature.State()) {
                    MainFeature()
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .beforeTraining(let type):
                    BeforeTrainingView(trainingType: type)
                case .training(let type):
                    TrainingView(trainingType: type)
                case .trainingList:
                    TrainingListView()
                }
            }
        }
        .tint(.osWblack)
    }
}
