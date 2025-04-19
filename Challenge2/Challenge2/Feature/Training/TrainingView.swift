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
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) private var modelContext

    @StateObject private var store: TrainingStore
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    @FocusState private var isFailureFocused: Bool
    @FocusState private var isNextFocused: Bool

    private let oswTip = OSWTip()
    let trainingType: TrainingType

    init(trainingType: TrainingType) {
        _store = StateObject(wrappedValue: TrainingStore(trainingType: trainingType))
        self.trainingType = trainingType
    }

    var body: some View {
        VStack {
            OSWProgressBar(
                totalSteps: trainingType.trainingList.count,
                currentStep: Binding(
                    get: { store.state.currentStep },
                    set: { _ in }
                )
            )
            .padding(.bottom, 35)

            VStack(alignment: .leading) {
                if store.state.currentStep == 1 || store.state.currentStep == 3 {
                    Text(trainingType.trainingList[0].title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)

                    ZStack {
                        OSWTextEditor(
                            text: Binding(
                                get: { store.state.failureText },
                                set: { store.send(.updateFailureText($0)) }
                            ),
                            placeholder: trainingType.trainingList[0].placeholder,
                            state: store.state.currentStep == 1 ? .focus : .normal
                        )
                        .focused($isFailureFocused)

                        if store.state.currentStep == 3 {
                            Rectangle()
                                .foregroundColor(.clear)
                                .contentShape(Rectangle())
                                .onTapGesture {}
                        }
                    }
                    .frame(height: 130)
                    .padding(.bottom, 28)
                }

                if store.state.currentStep >= 2 {
                    Text(trainingType.trainingList[1].title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)

                    ZStack {
                        OSWTextEditor(
                            text: Binding(
                                get: { store.state.nextText },
                                set: { store.send(.updateNextText($0)) }
                            ),
                            placeholder: trainingType.trainingList[1].placeholder,
                            state: store.state.currentStep == 2 ? .focus : .normal
                        )
                        .focused($isNextFocused)

                        if store.state.currentStep == 3 {
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
            
            if store.state.currentStep == 3 && !speechRecognizer.isRecognizedOsilwan {
                TipView(oswTip) { _ in
                    speechRecognizer.isRecognizedOsilwan = true
                    speechRecognizer.stopTranscribing()
                }
                .padding()
            }

            HStack(spacing: 12) {
                OSWButton(
                    style: .secondary,
                    size: .half,
                    title: "이전",
                    action: { store.send(.decrementStep) }
                )
                .disabled(store.state.currentStep == 1)

                OSWButton(
                    style: .active,
                    size: .half,
                    title: store.state.currentStep == 3 ? "완료" : "다음",
                    action: {
                        if store.state.currentStep == 3 {
                            let record = TrainingRecord(
                                trainingType: trainingType.rawValue,
                                failureText: store.state.failureText,
                                nextText: store.state.nextText
                            )
                            modelContext.insert(record)
                            coordinator.popToRoot()
                        } else {
                            store.send(.incrementStep)
                        }
                    }
                )
                .disabled(
                    store.state.isNextButtonDisabled ||
                    (store.state.currentStep == 3 && !speechRecognizer.isRecognizedOsilwan)

                )
            }
            .padding(.bottom, 10)
        }
        .navigationTitle(trainingType.title)
        .onAppear { updateFocus() }
        .onChange(of: store.state.currentStep) {
            updateFocus()
            Task {
                store.state.currentStep == 3
                ? try? await speechRecognizer.startTranscribing()
                : speechRecognizer.stopTranscribing()
            }
        }
    }
}

private extension TrainingView {
    func updateFocus() {
        switch store.state.currentStep {
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
