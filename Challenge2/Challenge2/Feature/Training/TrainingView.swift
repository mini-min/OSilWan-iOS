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
                    
                    ZStack {
                        OSWTextEditor(
                            text: $failureText,
                            placeholder: trainingType.trainingList[0].placeholder,
                            state: currentStep == 1 ? .focus : .normal
                        )
                        .focused($isFailureFocused)
                        
                        if currentStep == 3 {
                            Rectangle()
                                .foregroundColor(.clear)
                                .contentShape(Rectangle())
                                .onTapGesture {}
                        }
                    }
                    .frame(height: 130)
                    .padding(.bottom, 28)
                    
                }
                
                if currentStep >= 2 {
                    Text(trainingType.trainingList[1].title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    
                    ZStack {
                        OSWTextEditor(
                            text: $nextText,
                            placeholder: trainingType.trainingList[1].placeholder,
                            state: currentStep == 2 ? .focus : .normal
                        )
                        .focused($isNextFocused)
                        
                        if currentStep == 3 {
                            Rectangle()
                                .foregroundColor(.clear)
                                .contentShape(Rectangle())
                                .onTapGesture {}
                        }
                    }
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
                .disabled(currentStep == 1)
                
                OSWButton(
                    style: .active,
                    size: .half,
                    title: currentStep == 3 ? "완료" : "다음",
                    action: {
                        switch currentStep {
                        case 1, 2:
                            currentStep += 1
                            updateFocus()
                        default:
                            dismiss()
                            saveTrainingRecord()
                        }
                    }
                )
                .disabled(isNextButtonDisabled)
            }
            .padding(.bottom, 10)
        }
        .navigationTitle(trainingType.tite)
        .onAppear {
            updateFocus()
        }
    }
    
    private var isNextButtonDisabled: Bool {
        switch currentStep {
        case 1:
            return failureText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case 2:
            return nextText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        default:
            return false
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
