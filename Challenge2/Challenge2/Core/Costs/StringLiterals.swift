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
        case motivation5 = "실패는 끝이 아니라, 다음 도전을 위한 연습이에요.\n오늘도 멋진 시도를 해냈어요!"
        case motivation6 = "멈추지 않는 당신,\n그것만으로도 이미 충분히 잘하고 있어요."
        case motivation7 = "조금 느려도 괜찮아요.\n매일 나아가고 있다는 게 중요한 걸요."
        case motivation8 = "실패한 날도 기록하면,\n그건 언젠가 당신을 위로할 이야기가 될 거예요."
        case motivation9 = "실패는 무언가를 향해\n전력을 다했다는 증거예요!"
        case motivation10 = "오늘의 실패가 내일의 나를 단단하게 만들어줄 거예요.\n자신을 믿어봐요."
    }
}
