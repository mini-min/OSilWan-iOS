//
//  DetailTrainingType.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import Foundation

enum DetailTrainingType: CaseIterable {
    case writeFail
    case writeLearn
    case writeEmpathy
    case writeGoal
    case shoutFail
    
    var title: String {
        switch self {
        case .writeFail: "실패 기록하기"
        case .writeLearn: "배운점 작성하기"
        case .writeEmpathy: "스스로에게 "
        case .writeGoal: "실패 기록하기"
        case .shoutFail: "실패 기록하기"
        }
    }
    
    var description: String {
        switch self {
        case .writeFail: 
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        case .writeLearn: 
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        case .writeEmpathy:
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        case .writeGoal:
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        case .shoutFail:
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        }
    }

}
