//
//  DetailTrainingType.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import Foundation

enum DetailTrainingType {
    case writeFail, writeLearn, writeEmpathy, writeGoal, shoutFail
    
    var title: String {
        switch self {
        case .writeFail: "실패 기록하기"
        case .writeLearn: "배운점 작성하기"
        case .writeEmpathy: "스스로에게 한마디하기"
        case .writeGoal: "목표 작성하기"
        case .shoutFail: "오실완 외치기"
        }
    }
    
    var description: String {
        switch self {
        case .writeFail: 
            "“나는 무슨 실패를 했지?”\n실패를 구체적으로 떠올려보고 작성합니다."
        case .writeLearn: 
            "“그럼 실패를 통해 배운 점은 없을까?”\n떠올린 실패를 바탕으로 배운 점을 떠올려봅니다."
        case .writeEmpathy:
            "“스스로를 다정하게 위로해볼까요?”\n실패한 자신에게 따뜻한 한마디를 건네보세요."
        case .writeGoal:
            "“다시 도전할 목표를 세워볼까요?”\n실패를 극복하기 위한 목표를 작성해봅니다."
        case .shoutFail:
            "“오실완!” “오늘 실패 완료!”\n직접 오실완을 외치고 기록을 저장합니다."
        }
    }

    var placeholder: String {
        switch self {
        case .writeFail:
            """
            어떤 실패가 있었나요?
            언제, 어디서, 어떤 실패를 어떻게 겪었는지 
            최대한 구체적으로 작성해주세요!
            """
        case .writeLearn:
            """
            그럼에도 불구하고,
            그 실패를 통해 배운 점이 있지 않을까요?
            해당 실패를 통해 배운 점을 작성해주세요!
            """
        case .writeEmpathy:
            """
            실패한 나에게 어떤 말을 해주고 싶나요?
            스스로를 위로하고 다독이는 한마디를 작성해주세요!
            """
        case .writeGoal:
            """
            이번 실패를 발판삼아,
            앞으로의 목표를 어떻게 세울 수 있을까요?
            구체적인 목표를 작성해주세요!
            """
        case .shoutFail: ""
        }
    }
    
    var iconName: String {
        switch self {
        case .writeFail:
            return "icn_writeFail"
        case .writeLearn:
            return "icn_writeLearn"
        case .writeEmpathy:
            return "icn_writeEmpathy"
        case .writeGoal:
            return "icn_writeGoal"
        case .shoutFail:
            return "icn_shoutFail"
        }
    }
}
