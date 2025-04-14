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
    
    var tite: String {
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
            return "실패 과정에서 배운 점을 돌아보고,\n실패를 이겨냅니다."
        case .empathy:
            return "실패 과정 속 힘들었던 스스로에게\n정서적 위로가 될 수 있는 한마디를 작성합니다."
        case .goal:
            return "실패 과정에서 겪은 일을 통해"
        }
    }
    
    var image: Image {
        switch self {
        case .learning:
            return Image(ImageLiterals.test.rawValue)
        case .empathy:
            return Image(ImageLiterals.test.rawValue)
        case .goal:
            return Image(ImageLiterals.test.rawValue)
        }
    }
    
    var trainingList: [DetailTrainingType] {
        switch self {
        case .learning:
            return [.writeFail, .writeLearn, .shoutFail]
        case .empathy:
            return [.writeFail, .writeFail, .shoutFail]
        case .goal:
            return [.writeFail, .writeGoal, .shoutFail]
        }
    }
}
