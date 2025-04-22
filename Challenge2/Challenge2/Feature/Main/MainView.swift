//
//  MainView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("shouldAnimate") private var shouldAnimate: Bool = false
    
    @State private var currentMessage: String = StringLiterals.MainMessage.motivation1.rawValue
    @State private var currentFrame = 0
    @State private var isAnimating = false
    @State private var timer: Timer? = nil
    
    @Query private var records: [TrainingRecord]
        
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea(.all)
            
            VStack {
                Text.styledText(
                    fullText: "지금까지 \(records.count)개의 \n실패 트레이닝을 완료했어요!",
                    highlightedText: "\(records.count)",
                    baseFont: .title3.weight(.heavy),
                    highlightedFont: .title2.weight(.heavy)
                )
                .lineSpacing(5)
                .frame(width: 350, alignment: .leading)
                .padding(.top, 12)
                .padding(.bottom, 28)
                
                HStack(spacing: 12) {
                    ForEach(TrainingType.allCases, id: \.self) { type in
                        Button {
                            coordinator.push(.beforeTraining(trainingType: type))
                        } label: {
                            TrainingCard(type: type)
                        }
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    ZStack {
                        Image(.speechBubble)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280)

                        Text(currentMessage)
                            .font(.system(size: 12, weight: .bold))
                            .lineSpacing(8)
                            .foregroundColor(.sub)
                            .padding(.bottom, 40)
                    }
                    Image("\(min(currentFrame + 1, 13))")
                        .onTapGesture {
                            let candidates = StringLiterals.MainMessage.allCases.filter { $0.rawValue != currentMessage }
                            if let newMessage = candidates.randomElement() {
                                currentMessage = newMessage.rawValue
                            }
                            startAnimation()
                        }
                }
                .padding(.bottom, 40)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(.trainingList)
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .padding(.top, 16)
                        .padding(.trailing, 8)
                }
            }
        }
        .onAppear {
            currentFrame = 0
        }
        .onChange(of: shouldAnimate) {
            if shouldAnimate {
                startAnimation()
                shouldAnimate = false
            }
        }
    }
}

private extension MainView {
    func startAnimation() {
        guard !isAnimating else { return }
        isAnimating = true
        currentFrame = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 13.0, repeats: true) { time in
            currentFrame += 1
            if currentFrame >= 12 {
                time.invalidate()
                isAnimating = false
                currentFrame = 12
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
            .environmentObject(Coordinator())
    }
}
