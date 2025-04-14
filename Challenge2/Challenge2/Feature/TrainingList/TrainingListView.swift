//
//  TrainingListView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct Training: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}

struct TrainingListView: View {
    @State private var trainings: [Training] = [
        Training(title: "04.11의 실패 트레이닝", description: "오늘 아침에 일찍 일어나기를 실패해버리다...", icon: "drop.fill"),
        Training(title: "04.11의 실패 트레이닝", description: "오늘 아침에 일찍 일어나기를 실패해버리다...", icon: "drop.fill"),
        Training(title: "04.11의 실패 트레이닝", description: "오늘 아침에 일찍 일어나기를 실패해버리다...", icon: "drop.fill")
    ]
    
    @State private var filteredTrainings: [Training] = []
    @State private var filterType: String = "전체보기"
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.osWbackground
                    .ignoresSafeArea()
                
                VStack {
                    Menu {
                        Button("전체보기") { filterType = "전체보기"; applyFilter() }
                        Button("Learning Training") { filterType = "Learning"; applyFilter() }
                        Button("Empathy Training") { filterType = "Empathy"; applyFilter() }
                        Button("Goal Training") { filterType = "Goal"; applyFilter() }
                    } label: {
                        Text(filterType)
                            .font(.headline)
                            .padding()
                    }

                    List {
                        ForEach(filteredTrainings.isEmpty ? trainings : filteredTrainings) { training in
                            HStack {
                                Image(systemName: training.icon)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                VStack(alignment: .leading) {
                                    Text(training.title)
                                        .font(.headline)
                                    Text(training.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            trainings.remove(atOffsets: indexSet)
                            applyFilter()
                        }
                        .onMove { fromOffsets, toOffset in
                            trainings.move(fromOffsets: fromOffsets, toOffset: toOffset)
                            applyFilter()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                }
                .navigationTitle("Title")
            }
        }
    }
    
    private func applyFilter() {
        if filterType == "전체보기" {
            filteredTrainings = []
        } else {
            filteredTrainings = trainings.filter { $0.title.contains(filterType) }
        }
    }
}

#Preview {
    TrainingListView()
}
