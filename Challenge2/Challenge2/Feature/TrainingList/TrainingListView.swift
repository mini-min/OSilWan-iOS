//
//  TrainingListView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

struct TrainingListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditMode: Bool = false
    @State private var isDeleteAlertPresented: Bool = false
    @State private var selectedRecordForDeletion: TrainingRecord? = nil
    
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
                            contents: record.nextText,
                            onDelete: {
                                selectedRecordForDeletion = record
                                isDeleteAlertPresented = true
                            }
                        )
                        .frame(width: 343, height: 100)
                    }
                }
            }
        }
        .navigationTitle("Title")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        isEditMode.toggle()
                    }
                }) {
                    Text(isEditMode ? "완료" : "편집")
                }
            }
        }
        .alert("삭제", isPresented: $isDeleteAlertPresented, presenting: selectedRecordForDeletion) { record in
            Button("삭제", role: .destructive) {
                withAnimation {
                    modelContext.delete(record)
                    try? modelContext.save()
                }
            }
            Button("취소", role: .cancel) {}
        } message: { _ in
            Text("선택한 실패 트레이닝을 삭제할까요?\n해당 트레이닝 내역은 복원되지 않습니다.")
        }
    }
}

#Preview {
    NavigationStack {
        TrainingListView()
    }
}
