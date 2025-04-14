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
    @FocusState private var isFocused: Bool
    
    private let placeholder: String
    
    // MARK: - Init
    
    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self._text = text
        self.placeholder = placeholder
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.oswGray1)
                    .font(.system(size: 16))
                    .padding(.all, 20)
            }
            
            TextEditor(text: $text)
                .focused($isFocused)
                .padding(16)
                .font(.system(size: 14))
                .foregroundColor(.osWblack)
                .background(.oswGray3)
        }
        .frame(minHeight: 130)
        .background(.oswGray3)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.main, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    OSWTextEditor(text: .constant(""), placeholder: "어쩌구")
}
