//
//  TrainingListView.swift
//  Challenge2
//
//  Created by mini on 4/13/25.
//

import SwiftUI
import SwiftData

struct TrainingListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var coordinator: Coordinator
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
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea()
            
            VStack {
                if isEditMode {
                    Spacer(minLength: 24)
                } else {
                    TrainingListHeaderSection(selectedFilter: $selectedFilter)
                }
                
                TrainingListSection(
                    isEditMode: $isEditMode,
                    filteredRecords: filteredRecords
                ) { record in
                    selectedRecordForDeletion = record
                    isDeleteAlertPresented = true
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation { isEditMode.toggle() }
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
            Text(String(localized: "delete_alert"))
        }
    }
    
    // MARK: - [SubViews] Training List Header Section
    
    struct TrainingListHeaderSection: View {
        @Binding var selectedFilter: TrainingType?
        
        var body: some View {
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
    }
    
    // MARK: - [SubViews] Training List Section
    
    struct TrainingListSection: View {
        @Binding var isEditMode: Bool
        private(set) var filteredRecords: [TrainingRecord]
        private(set) var onDelete: (TrainingRecord) -> Void
        
        var body: some View {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredRecords) { record in
                        TrainingListCard(
                            isEditMode: $isEditMode,
                            imageName: record.trainingTypeEnum.imageName,
                            date: record.savedDate,
                            contents: record.nextText,
                            onDelete: { onDelete(record) }
                        )
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
    
    // MARK: - [SubViews] Training List Card
    
    struct TrainingListCard: View {
        @Binding var isEditMode: Bool
        
        private(set) var imageName: String
        private(set) var date: Date
        private(set) var contents: String
        private(set) var onDelete: () -> Void
        
        var body: some View {
            HStack {
                if isEditMode {
                    Button(action: onDelete) {
                        Image(.icnDelete)
                            .padding(.trailing, 10)
                    }
                }
                
                HStack {
                    if !isEditMode {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65, height: 65)
                            .padding(.leading, 12)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(date.toMonthDayString)의 실패 트레이닝")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundStyle(.osWblack)
                        
                        Text(contents)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.oswGray1)
                            .lineSpacing(4)
                            .frame(width: 234, alignment: .leading)
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 12)
                    .frame(minHeight: 100, alignment: .leading)
                    
                    Spacer()
                }
                .background(.osWwhite)
                .cornerRadius(12)
            }
        }
    }
}
