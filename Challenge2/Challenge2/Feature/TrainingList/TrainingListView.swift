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
    @Query(sort: \TrainingRecord.savedDate, order: .reverse) private var records: [TrainingRecord]
    
    @State private var isEditMode: Bool = false
    @State private var isDeleteAlertPresented: Bool = false
    @State private var selectedRecordForDeletion: TrainingRecord? = nil
    @State private var selectedFilter: TrainingType? = nil
    
    private var filteredRecords: [TrainingRecord] {
        guard let selectedFilter else { return records }
        return records.filter { $0.trainingType == selectedFilter.rawValue }
    }
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea()
            
            VStack {
                if isEditMode {
                    Spacer(minLength: 24)
                } else {
                    HStack {
                        Menu {
                            Button("전체보기") { selectedFilter = nil }
                            Section {
                                ForEach(TrainingType.allCases, id: \.self) { type in
                                    Button(type.title) {
                                        selectedFilter = type
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedFilter?.title ?? "전체")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(Color.osWblack)
                            .padding(.leading, 20)
                        }
                        Spacer()
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredRecords) { record in
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
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            
        }
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
            Text(StringLiterals.AlertMessage.deleteTraining)
        }
    }
}
