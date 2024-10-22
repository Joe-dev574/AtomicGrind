//
//  ContentView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData


enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, objectiveTitle, objectiveDescription
    
    var id: Self {
        self
    }
}

struct ContentView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query private var objectives: [Objective]
    @State private var showAddObjectiveScreen: Bool = false
    @State private var filter = ""
    @State private var sortOrder = SortOrder.status
    
    var body: some View {
        NavigationSplitView {
            List{
                Picker("", selection: $sortOrder) {
                    ForEach(SortOrder.allCases) { sortOrder in
                        Text("\(sortOrder.rawValue)").tag(sortOrder)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .searchable(text: $filter)
                ForEach(objectives) { objective in
                    NavigationLink{
                        EditObjectiveScreen( )
                    } label: {
                        ObjectiveCardView( objective: objective)
                    }
                }
            }
#if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                .toolbar {
#if os(iOS)
                    ///profile pic button
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button{
                            HapticManager.notification(type: .success)
                            
                        } label: {
                            ZStack{
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 44 , height: 44)
                                Image("profileLogo2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(.circle)
                                
                                    .frame(width: 40 , height: 40 )
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        LogoView()
                    }
#endif
                    ///add objective
                    ToolbarItem {
                        Button{
                            showAddObjectiveScreen.toggle()
                            HapticManager.notification(type: .success)
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(.blue.gradient.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
                        }
                    }
                }.padding(.horizontal)
                .sheet(isPresented: $showAddObjectiveScreen, content: {
                    AddObjectiveScreen()
                        .presentationDetents([.height(650)])
                        .interactiveDismissDisabled()
                        .presentationCornerRadius(30)
                })
            } detail: {
                Text("Select an item")
                Text("Select an item")
            }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Objective.self, inMemory: true)
}

