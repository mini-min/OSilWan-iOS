//
//  MainView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct MainView: View {
    @State private var isListViewActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.osWbackground
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 12) {
                        ForEach(TrainingType.allCases, id: \.self) { type in
                            NavigationLink {
                                BeforeTrainingView(trainingType: type)
                            } label: {
                                TrainingCard(title: type.tite)
                            }
                        }
                    }
                    
                    Text("지금까지 00개의 트레이닝을 완료했어요!")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    
                }
            }
            .navigationTitle("Title")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isListViewActive = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .navigationDestination(isPresented: $isListViewActive) {
                TrainingListView()
            }
        }
    }
}

#Preview {
    MainView()
}
