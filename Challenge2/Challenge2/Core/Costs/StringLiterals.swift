//
//  StringLiterals.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import Foundation

enum StringLiterals {
    enum AlertMessage {
        static let deleteTraining = "선택한 실패 트레이닝을 삭제할까요?\n해당 트레이닝 내역은 복원되지 않습니다."
    }
    
    enum MainMessage: String, CaseIterable {
        case motivation1 = "실패하지 않는다는 것은, 멈췄다는 의미래요.\n오늘의 실패를 완료하고,\n멈춰있지 않다는 것을 증명해보지 않을래요?"
        case motivation2 = "오늘도 한 걸음 나아갔어요.\n실패도 훈련이에요!"
        case motivation3 = "멋지게 실패한 당신,\n그 자체로 대단해요!"
        case motivation4 = "도전했다는 건 이미 절반을 해낸 거예요!"
    }
}
