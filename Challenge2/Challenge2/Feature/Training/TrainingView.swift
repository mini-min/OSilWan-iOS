//
//  TrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var currentStep: Int = 1
    @State private var failureText = ""
    @State private var nextText = ""
    
    @FocusState private var isFailureFocused: Bool
    @FocusState private var isNextFocused: Bool
    
    let trainingType: TrainingType
    
    var body: some View {
        VStack {
            OSWProgressBar(totalSteps: 3, currentStep: $currentStep)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading) {
                if currentStep == 1 || currentStep == 3 {
                    Text(trainingType.trainingList[0].title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    OSWTextEditor(
                        text: $failureText,
                        placeholder: trainingType.trainingList[0].placeholder,
                        state: currentStep == 1 ? .focus : .normal
                    )
                    .focused($isFailureFocused)
                    .frame(height: 130)
                    .padding(.bottom, 28)
                }
                
                if currentStep >= 2 {
                    Text(trainingType.trainingList[1].title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    OSWTextEditor(
                        text: $nextText,
                        placeholder: trainingType.trainingList[1].placeholder,
                        state: currentStep == 2 ? .focus : .normal
                    )
                    .focused($isNextFocused)
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
                        if currentStep > 1 {
                            currentStep -= 1
                            updateFocus()
                        }
                    }
                )
                
                OSWButton(
                    style: .active,
                    size: .half,
                    title: currentStep == 3 ? "완료" : "다음",
                    action: {
                        if currentStep == 3 {
                            dismiss()
                            saveTrainingRecord()
                        } else {
                            currentStep += 1
                            updateFocus()
                        }
                    }
                )
            }
            .padding(.bottom, 10)
        }
        .navigationTitle(trainingType.tite)
        .onAppear {
            updateFocus()
        }
    }
}

private extension TrainingView {
    func saveTrainingRecord() {
        let record = TrainingRecord(
            trainingType: trainingType.rawValue,
            failureText: failureText,
            nextText: nextText
        )
        modelContext.insert(record)
    }
}

private extension TrainingView {
    func updateFocus() {
        switch currentStep {
        case 1:
            isFailureFocused = true
        case 2:
            isNextFocused = true
        default:
            isFailureFocused = false
            isNextFocused = false
        }
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
