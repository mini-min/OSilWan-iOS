//
//  OSWTextField.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

public struct OSWTextEditor: View {
    
    // MARK: - Properties
    
    @Binding var text: String
    let placeholder: String
    let state: OSWTextFieldStatus
        
    // MARK: - Init
    
    init(
        text: Binding<String>,
        placeholder: String,
        state: OSWTextFieldStatus
    ) {
        self._text = text
        self.placeholder = placeholder
        self.state = state
    }
    
    // MARK: - Body
    
    public var body: some View {
        TextEditor(text: $text)
        .padding(15)
        .background(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .lineSpacing(10)
                    .padding(20)
                    .font(.system(size: 16))
                    .foregroundColor(.oswGray1)
            }
        }
        .background(.oswGray3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .scrollContentBackground(.hidden)
        .font(.system(size: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(state.borderColor, lineWidth: 2)
        )
    }
}

// MARK: - Button Status

public enum OSWTextFieldStatus {
    case normal
    case focus
    
    var borderColor: Color {
        switch self {
        case .normal: return .clear
        case .focus: return .main
        }
    }
}

// MARK: - Preview

#Preview {
    OSWTextEditor(
        text: .constant(""),
        placeholder: """
        그럼에도 불구하고,\n그 실패를 통해 배운 점이 있지 않을까요?\n해당 실패를 통해 배운 점을 작성해주세요!
        """,
        state: .focus
    )
}
