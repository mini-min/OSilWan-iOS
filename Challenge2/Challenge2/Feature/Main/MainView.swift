//
//  MainView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

enum MainStatus {
    case normal, animating
}

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("shouldAnimate") private var shouldAnimate: Bool = false
    
    @State private var currentMessage: String = StringLiterals.MainMessage.motivation1.rawValue
    @State private var currentFrame = 0
    @State private var isAnimating = false
    @State private var timer: Timer? = nil
    
    @Query private var records: [TrainingRecord]
    
    var status: MainStatus = .animating
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea(.all)
            
            VStack {
                HStack(spacing: 12) {
                    ForEach(TrainingType.allCases, id: \.self) { type in
                        Button {
                            coordinator.push(.beforeTraining(trainingType: type))
                        } label: {
                            TrainingCard(type: type)
                        }
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                
                Text("지금까지 \(records.count)개의 트레이닝을 완료했어요!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .leading)
                    .padding(.bottom, -20)
                
                VStack(spacing: -30) {
                    ZStack {
                        Image(.speechBubble)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 380)

                        Text(currentMessage)
                            .font(.system(size: 14, weight: .heavy))
                            .lineSpacing(8)
                            .foregroundColor(.osWblack)
                            .padding(.bottom, 20)
                    }
                    Image("\(min(currentFrame + 1, 13))")
                        .onTapGesture {
                            let candidates = StringLiterals.MainMessage.allCases.filter { $0.rawValue != currentMessage }
                            if let newMessage = candidates.randomElement() {
                                currentMessage = newMessage.rawValue
                            }
                        }
                }
                .padding(.bottom, 30)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(.trainingList)
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .padding(.top, 16)
                        .padding(.trailing, 8)
                }
            }
            
//            ToolbarItem(placement: .topBarLeading) {
//                Image(.mainLogo)
//                    .padding(.top, 16)
//                    .padding(.leading, 8)
//            }
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
