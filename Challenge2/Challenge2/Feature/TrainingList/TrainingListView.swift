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
    
    @Query(sort: \TrainingRecord.savedDate, order: .reverse) private var records: [TrainingRecord]

    var body: some View {
        ZStack {
            Color.osWbackground.ignoresSafeArea()

            List {
                ForEach(records) { record in
                    HStack {
                        Image(systemName: "drop.fill")
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(record.trainingType)  // 저장한 타입
                                .fontWeight(.bold)

                            Text(record.failureText)  // 저장한 실패 텍스트
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
                    for index in indexSet {
                        modelContext.delete(records[index])
                    }
                }
                .onMove { indices, newOffset in
                    // items.move(fromOffsets: indices, toOffset: newOffset)
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
