//
//  OSWTip.swift
//  Challenge2
//
//  Created by mini on 4/19/25.
//

import TipKit

struct OSWTip: Tip {
    var title: Text {
        Text("오실완을 외쳐보세요!")
    }
    
    var message: Text? {
        Text("단어가 인식되면, 완료 버튼이 활성화됩니다.")
    }
    
    var image: Image? {
        Image(systemName: "person.wave.2.fill")
    }
    
    var actions: [Action] {
        Action {
            Text("지금 말할 수 없어요")
                .foregroundStyle(.main)
        }
    }
}
