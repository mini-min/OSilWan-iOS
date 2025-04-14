//
//  Text+.swift
//  Challenge2
//
//  Created by mini on 4/14/25.
//

import SwiftUI

extension Text {
    
    /// 특정 문자열을 다른 스타일로 꾸미는 함수
    static func styledText(
        fullText: String,
        highlighted: String,
        highlightColor: Color = .red,
        highlightFont: Font = .headline
    ) -> Text {
        let parts = fullText.components(separatedBy: highlighted)
        var styled = Text("")

        for index in 0..<parts.count {
            styled = styled + Text(parts[index])
                .font(.body)   

            if index != parts.count - 1 {
                styled = styled + Text(highlighted)
                    .font(highlightFont)
                    .foregroundColor(highlightColor)
            }
        }

        return styled
    }
}
