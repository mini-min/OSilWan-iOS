//
//  TrainingView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData
import TipKit

struct TrainingView: View {
    
    // MARK: - Properties

    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) private var modelContext
    @AppStorage("shouldAnimate") private var shouldAnimate: Bool = false

    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    @State private var currentStep: Int = 1
    @State private var failureText: String = ""
    @State private var nextText: String = ""
    @FocusState private var isFailureFocused: Bool
    @FocusState private var isNextFocused: Bool
    
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
    private(set) var trainingType: TrainingType
    
    // MARK: - UI Components

    private let oswTip = OSWTip()

    // MARK: - Body

    var body: some View {
        VStack {
            OSWProgressBar(
                totalSteps: trainingType.trainingList.count,
                currentStep: $currentStep
            )
            .padding([.horizontal, .top], 8)
            .padding(.bottom, 35)

            TrainingInputSection(
                currentStep: $currentStep,
                failureText: $failureText,
                nextText: $nextText,
                isFailureFocused: $isFailureFocused,
                isNextFocused: $isNextFocused,
                trainingType: trainingType
            )

            Spacer()
            
            if currentStep == 3 && !speechRecognizer.isRecognizedOsilwan {
                TipView(oswTip) { _ in
                    speechRecognizer.isRecognizedOsilwan = true
                    speechRecognizer.stopTranscribing()
                }
                .tint(.main)
                .padding()
            }
            
            BottomButtonSection(
                currentStep: $currentStep,
                isNextButtonDisabled: .constant(isNextButtonDisabled),
                isRecognizedOsilwan: speechRecognizer.isRecognizedOsilwan
            ) {
                let record = TrainingRecord(
                    trainingType: trainingType.rawValue,
                    failureText: failureText,
                    nextText: nextText
                )
                modelContext.insert(record)
                coordinator.popToRoot()
                shouldAnimate = true
            }
        }
        .navigationTitle(trainingType.title)
        .onAppear { updateFocus() }
        .onChange(of: currentStep) {
            updateFocus()
            Task {
                currentStep == 3
                ? try? await speechRecognizer.startTranscribing()
                : speechRecognizer.stopTranscribing()
            }
        }
        .onChange(of: speechRecognizer.isRecognizedOsilwan) { _, newValue in
            if newValue {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        }
    }
    
    // MARK: - [SubViews] Training Input Section
    
    struct TrainingInputSection: View {
        @Binding var currentStep: Int
        @Binding var failureText: String
        @Binding var nextText: String
        @FocusState.Binding var isFailureFocused: Bool
        @FocusState.Binding var isNextFocused: Bool
        
        private(set) var trainingType: TrainingType
        
        var body: some View {
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
        }
    }
    
    // MARK: - [SubViews] Bottom Button Section
    
    struct BottomButtonSection: View {
        @Binding var currentStep: Int
        @Binding var isNextButtonDisabled: Bool
        private(set) var isRecognizedOsilwan: Bool
        private(set) var onCompleteTraining: () -> Void
        
        var body: some View {
            HStack(spacing: 12) {
                OSWButton(
                    style: .secondary,
                    size: .half,
                    title: "이전",
                    action: { currentStep -= 1 }
                )
                .disabled(currentStep == 1)
                
                OSWButton(
                    style: .active,
                    size: .half,
                    title: currentStep == 3 ? "완료" : "다음",
                    action: {
                        if currentStep == 3 {
                            onCompleteTraining()
                        } else {
                            currentStep += 1
                        }
                    }
                )
                .disabled(isNextButtonDisabled || (currentStep == 3 && !isRecognizedOsilwan))
            }
            .padding(.bottom, 10)
        }
    }
}

// MARK: - [Extension] Private Methods

private extension TrainingView {
    /// TextEditor의 focus를 제어하기 위한 메서드
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
}
