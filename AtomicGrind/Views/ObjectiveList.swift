//
//  ObjectiveList.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/22/24.
//


import SwiftUI
import SwiftData



struct ObjectiveList: View {
    @Environment(\.modelContext) private var context
    @State private var showAddObjectiveScreen: Bool = false
    @State private var showEditObjectiveScreen: Bool = false
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
   
                if objectives.isEmpty {
                    ContentUnavailableView {
                        Label("No Objectives Found", systemImage: "exclamationmark.triangle.fill") .foregroundStyle(.yellow)
                    } description: {
                        Text("Begin creating your Daily Objectives.").fontDesign(.serif).font(.title3)
                    } actions: {
                        Button("New Objective") {
                            showAddObjectiveScreen = true
                            HapticManager.notification(type: .success)
                        }.buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(objectives) { objective in
                    
                                NavigationLink {
                                    EditObjectiveScreen(objective: objective)
                                } label: {
                                    ObjectiveCardView(objective: objective)
                                }
                                .listRowSeparator(.hidden)
                            }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let objective = objectives[index]
                                context.delete(objective)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .sheet(isPresented: $showAddObjectiveScreen, content: {
                        AddObjectiveScreen()
                            .presentationDetents([.height(400)])
                            .interactiveDismissDisabled()
                            .presentationCornerRadius(30)
                    })
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
