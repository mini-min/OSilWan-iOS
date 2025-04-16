//
//  TrainingListView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

struct TrainingListView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditMode: Bool = false
    
    @Query(sort: \TrainingRecord.savedDate, order: .reverse) private var records: [TrainingRecord]
    @State private var dummyRecords: [TrainingRecord] = [
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
        TrainingRecord(trainingType: "learning", failureText: "실패", nextText: "실패가 어쩌구저쩌구 했기 때문에 어쩌구 저쩌구 거쩌구 저쩌구 방구가 어쩌구우"),
    ]

    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(dummyRecords) { record in
                        TrainingListCard(
                            isEditMode: $isEditMode,
                            imageName: record.trainingTypeEnum.imageName,
                            date: record.savedDate,
                            contents: record.nextText
                        )
                        .frame(width: 343, height: 100)
                    }
                }
            }
        }
        .navigationTitle("Title")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        TrainingListView()
    }
}
