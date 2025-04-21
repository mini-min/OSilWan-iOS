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
        highlightedText: String,
        baseColor: Color = .osWblack,
        baseFont: Font = .body,
        highlightedColor: Color = .main,
        highlightedFont: Font = .headline
    ) -> Text {
        let parts = fullText.components(separatedBy: highlightedText)
        var styled = Text("")
        
        for (index, partText) in parts.enumerated() {
            styled = styled + Text(partText)
                .foregroundStyle(baseColor)
                .font(baseFont)
            
            if index < parts.count - 1 {
                styled = styled + Text(highlightedText)
                    .foregroundStyle(highlightedColor)
                    .font(highlightedFont)
            }
        }

        return styled
    }
}
