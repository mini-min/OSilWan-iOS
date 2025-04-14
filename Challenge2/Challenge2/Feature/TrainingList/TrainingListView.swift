//
//  TrainingListView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI

struct TrainingItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct TrainingListView: View {
    @State private var items = [
        TrainingItem(title: "04.11의 실패 트레이닝", subtitle: "오늘 아침에 일찍 일어나기를 실패해버리다..."),
        TrainingItem(title: "04.11의 실패 트레이닝", subtitle: "오늘 아침에 일찍 일어나기를 실패해버리다..."),
        TrainingItem(title: "04.11의 실패 트레이닝", subtitle: "오늘 아침에 일찍 일어나기를 실패해버리다...")
    ]
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea()
            
            List {
                ForEach(items) { item in
                    HStack {
  
                        Image(systemName: "drop.fill")
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(item.title)
                                .fontWeight(.bold)
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        if editMode?.wrappedValue == .active {
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    items.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Title")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}
