//
//  TrainingType.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

enum TrainingType: String, CaseIterable {    
    case learning
    case empathy
    case goal
    
    var title: String {
        switch self {
        case .learning:
            return "Learning Training"
        case .empathy:
            return "Empathy Training"
        case .goal:
            return "Goal Training"
        }
    }
    
    var description: String {
        switch self {
        case .learning:
            return "실패 과정 속에서 배운 점을 생각하며,\n이를 통해 한 단계 성장한 스스로를 돌아봅니다."
        case .empathy:
            return "실패 과정 속 힘들었던 스스로에게\n정서적 위로가 될 수 있는 한마디를 작성합니다."
        case .goal:
            return "기존의 실패를 밑바탕으로\n새로운 목표를 세워보며, 실패를 이겨냅니다."
        }
    }
    
    var imageName: String {
        switch self {
        case .learning:
            return ImageLiterals.osilwan.rawValue
        case .empathy:
            return ImageLiterals.osilwan.rawValue
        case .goal:
            return ImageLiterals.osilwan.rawValue
        }
    }
    
    var trainingList: [DetailTrainingType] {
        switch self {
        case .learning:
            return [.writeFail, .writeLearn, .shoutFail]
        case .empathy:
            return [.writeFail, .writeEmpathy, .shoutFail]
        case .goal:
            return [.writeFail, .writeGoal, .shoutFail]
        }
    }
}
