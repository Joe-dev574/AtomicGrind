//
//  ObjectiveList.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/22/24.
//

import SwiftUI

import SwiftUI
import SwiftData

struct ObjectiveList: View {
    @Environment(\.modelContext) private var context
    @Query private var objectives: [Objective]
    init(filterString: String) {
        let predicate = #Predicate<Objective> { objective in
            objective.title.localizedStandardContains(filterString)
            || objective.summary.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _objectives = Query(filter: predicate)
    }
    var body: some View {
        Group {
            if objectives.isEmpty {
                ContentUnavailableView("Enter your first objective.", systemImage: "book.fill")
            } else {
                List {
                    ForEach(objectives) { objective in
                        NavigationLink {
                            EditObjectiveScreen()
                        } label: {
                            HStack(spacing: 10) {
                                objective.icon
                                VStack(alignment: .leading) {
                                    Text(objective.title).font(.title2)
                                    Text(objective.summary).foregroundStyle(.secondary)
                                        
                                    if let targetTags = objective.targetTags {
                                        ViewThatFits {
                                            TargetTagsStackView(targetTags: targetTags)
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                TargetTagsStackView(targetTags: targetTags)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let objective = objectives[index]
                            context.delete(objective)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = Preview(Objective.self)
    preview.addExamples(Objective.sampleObjectives)
    return NavigationStack {
        ObjectiveList(filterString: "")
    }
        .modelContainer(preview.container)
}
