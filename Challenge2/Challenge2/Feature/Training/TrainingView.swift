//
//  TrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: Int = 1
    @State private var failureText = ""
    @State private var nextText = ""
    
    let trainingType: TrainingType
    
    var body: some View {
        VStack {
            OSWProgressBar(totalSteps: 3, currentStep: $currentStep)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading) {
                Text("실패 기록하기")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                OSWTextEditor(
                    text: $failureText,
                    placeholder:
"""
어떤 실패가 있었나요?
언제, 어디서, 어떤 실패를 어떻게 겪었는지
최대한 구체적으로 작성해주세요!
""",
                    state: failureText.isEmpty ? .normal : .focus
                )
                .frame(height: 130)
                .padding(.bottom, 28)
                
                if currentStep >= 2 {
                    Text("배운점 작성하기")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    OSWTextEditor(
                        text: $nextText,
                        placeholder:
    """
    그럼에도 불구하고,
    그 실패를 통해 배운 점이 있지 않을까요?
    해당 실패를 통해 배운 점을 작성해주세요!
    """,
                        state: failureText.isEmpty ? .normal : .focus
                    )
                    .frame(height: 130)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            HStack(spacing: 12) {
                OSWButton(
                    style: .secondary,
                    size: .half,
                    title: "이전",
                    action: {
                        if currentStep > 1 { currentStep -= 1 }
                    }
                )
                
                OSWButton(
                    style: .active,
                    size: .half,
                    title: currentStep == 3 ? "완료" : "다음",
                    action: {
                        if currentStep == 3 {
                            dismiss()
                        } else {
                            currentStep += 1
                        }
                    }
                )
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    TrainingView(trainingType: .learning)
}
