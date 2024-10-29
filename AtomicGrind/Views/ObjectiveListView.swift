//
//  ObjectiveListView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData


enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case Status, Title, Summary
    
    var id: Self {
        self
    }
}

struct ObjectiveListView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query private var objectives: [Objective]
    @State private var showAddObjectiveScreen: Bool = false
    @State private var filter = ""
   
    
    var body: some View {
        NavigationStack{
            VStack {
                
                ObjectiveList(filterString: filter)
                
            }

         

                .toolbar {

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
                                .background(.blue.gradient.shadow(.drop(color: .black.opacity(0.55), radius: 2, x:2, y: 2)), in: .circle)
                        }
                    }
                }.padding(.horizontal)
                    .sheet(isPresented: $showAddObjectiveScreen, content: {
                        AddObjectiveScreen()
                            .presentationDetents([.height(650)])
                            .interactiveDismissDisabled()
                            .presentationCornerRadius(30)
                    })
            
        } 
    }
}
#Preview("English") {
    let preview = Preview(Objective.self)
    let objectives = Objective.sampleObjectives
    let targetTags = TargetTag.sampleTargetTags
    preview.addExamples(objectives)
    preview.addExamples(targetTags)
    return ObjectiveListView()
        .modelContainer(preview.container)
}
