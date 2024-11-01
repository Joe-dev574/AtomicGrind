//
//  targetTagView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/24/24.
//

import SwiftData
import SwiftUI

struct TargetTagView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var objective: Objective
    @Query(sort: \TargetTag.name) var targetTags: [TargetTag]
    @State private var newTargetTag = false
    var body: some View {
        NavigationStack {
            VStack{
                if targetTags.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "scope")
                            .font(.largeTitle)
                    } description: {
                        Text("Create tags for your objectives.  The tags should be descriptive of the scope of work, you are trying to achieve.  For example, \"Work\" or \"School\".   ")
                    } actions: {
                        Button("Create Tags") {
                            newTargetTag.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(targetTags) { targetTag in
                            HStack {
                                if let objectiveTargetTags = objective.targetTags {
                                    if objectiveTargetTags.isEmpty {
                                        Button {
                                            addRemove(targetTag)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(targetTag.hexColor)
                                    } else {
                                        Button {
                                            addRemove(targetTag)
                                        } label: {
                                            Image(systemName: targetTags.contains(targetTag) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(targetTag.hexColor)
                                    }
                                }
                                Text(targetTag.name)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                if let objectiveTargetTags = objective.targetTags,
                                   objectiveTargetTags.contains(targetTags[index]),
                                   let objectiveTargetTagIndex = objectiveTargetTags.firstIndex(where: {$0.id == targetTags[index].id}) {
                                    objective.targetTags?.remove(at: objectiveTargetTagIndex)
                                }
                                context.delete(targetTags[index])
                            }
                        })
                        LabeledContent {
                            Button {
                                newTargetTag.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create new Genre")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .sheet(isPresented: $newTargetTag) {
                    NewTargetTag()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back") {
                                dismiss()
                            }
                        }
                    }
            
        }
    }
    func addRemove(_ targetTag: TargetTag) {
        if let objectiveTargetTags = objective.targetTags {
            if objectiveTargetTags.isEmpty {
                objective.targetTags?.append(targetTag)
            } else {
                if objectiveTargetTags.contains(targetTag),
                   let index = objectiveTargetTags.firstIndex(where: {$0.id == targetTag.id}) {
                    objective.targetTags?.remove(at: index)
                } else {
                    objective.targetTags?.append(targetTag)
                }
            }
        }
    }
}

//#Preview {
//    let preview = Preview(Book.self)
//    let books = Book.sampleBooks
//    let genres = Genre.sampleGenres
//    preview.addExamples(genres)
//    preview.addExamples(books)
//    books[1].genres?.append(genres[0])
//    return GenresView(book: books[1])
//        .modelContainer(preview.container)
//}
