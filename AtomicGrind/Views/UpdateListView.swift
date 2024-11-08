//
//  UpdateListView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 11/7/24.
//

import SwiftUI

struct UpdatesListView: View {
    @Environment(\.modelContext) private var modelContext
    let objective: Objective
    @State private var text = ""
    @State private var page = ""
    @State private var selectedUpdate: Update?
    var isEditing: Bool {
        selectedUpdate != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("page #", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedUpdate = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedUpdate?.text = text
                        selectedUpdate?.page = page.isEmpty ? nil : page
                        page = ""
                        text = ""
                        selectedUpdate = nil
                    } else {
                        let update = page.isEmpty ?  Update(text: text) : Update(text: text, page: page)
                        objective.updates?.append(update)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .frame(height: 400)
        }
        .padding(.horizontal)
        List {
            let sortedUpdates = objective.updates?.sorted(using: KeyPathComparator(\Update.creationDate)) ?? []
            ForEach(sortedUpdates) { update in
                VStack(alignment: .leading) {
                    Text(update.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(update.text)
                    HStack {
                        Spacer()
                        if let page = update.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedUpdate = update
                    text = update.text
                    page = update.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        let update = sortedUpdates[index]
                        objective.updates?.forEach({ objectiveUpdate in
                            if update.id == objectiveUpdate.id {
                                modelContext.delete(update)
                            }
                        })
                    }
                }
            }
        }
        .listStyle(.plain)
      
    }
}


