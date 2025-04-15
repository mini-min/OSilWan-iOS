//
//  OSWButton.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

public struct OSWButton: View {
    
    // MARK: - Properties
    
    @Environment(\.isEnabled) private var isEnabled

    let style: OSWButtonStyle
    let size: OSWButtonSize
    private let title: String
    let action: () -> Void
    
    // MARK: - Init

    public init(
        style: OSWButtonStyle,
        size: OSWButtonSize,
        title: String,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.size = size
        self.title = title
        self.action = action
    }
    
    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(isEnabled ? style.textColor : .osWwhite)
                .frame(width: size.width, height: size.height)
                .background(isEnabled ? style.backgroundColor : .oswGray2)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

// MARK: - Button Size

public enum OSWButtonSize {
    case full
    case half
    
    var width: CGFloat {
        switch self {
        case .full: 327
        case .half: 160
        }
    }
    
    var height: CGFloat {
        switch self {
        case .full: 54
        case .half: 48
        }
    }
}

// MARK: - Button Style

public enum OSWButtonStyle {
    case active
    case secondary
    
    var backgroundColor: Color {
        switch self {
        case .active: .main
        case .secondary: .oswGray3
        }
    }
    
    var textColor: Color {
        switch self {
        case .active: .osWblack
        case .secondary: .oswGray1
        }
    }
}

// MARK: - Preview

#Preview {
    OSWButton(style: .active, size: .full, title: "완료", action: {})
        .disabled(true)
}
