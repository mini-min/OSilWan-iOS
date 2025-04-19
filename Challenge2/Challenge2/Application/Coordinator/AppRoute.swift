//
//  AppRoute.swift
//  Challenge2
//
//  Created by mini on 4/19/25.
//

import Foundation

enum AppRoute: Hashable {
    case beforeTraining(trainingType: TrainingType)
    case training(trainingType: TrainingType)
    case trainingList
}
