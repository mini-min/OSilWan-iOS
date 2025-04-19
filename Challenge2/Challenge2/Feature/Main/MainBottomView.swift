//
//  MainBottomView.swift
//  Challenge2
//
//  Created by mini on 4/19/25.
//

import SwiftUI

struct MainBottomView: View {
    @Binding var currentMessage: String
    
    var body: some View {
        VStack(spacing: -50) {
            ZStack {
                Image(.speechBubble)

                Text(currentMessage)
                    .font(.caption)
                    .lineSpacing(8)
                    .foregroundColor(.osWblack)
                    .padding(.bottom, 60)
            }
            
            Image(.osilwan)
        }

    }
}

#Preview {
    MainBottomView(currentMessage: .constant(StringLiterals.MainMessage.motivation1.rawValue))
}
