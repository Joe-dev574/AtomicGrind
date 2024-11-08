//
//  EditObjectiveScreen.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/21/24.
//

import SwiftUI
import PhotosUI
import SwiftData



struct EditObjectiveScreen: View {
    @Environment(\.dismiss) private var dismiss
    let objective: Objective
    
    @State private var status = Status.Queue
 
    @State private var title = ""
    @State private var objectiveColor = Color.accentColor
    @State private var summary = ""
    @State private var dateAdded: Date = .init()
    @State private var dateStarted: Date = .init()
    @State private var dateCompleted: Date = .init()
    @State private var showTargetTags = false
    init(objective: Objective) {
        self.objective = objective
        _status = State(initialValue: Status(rawValue: objective.status)!)
    }
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    //MARK:  STATUS PICKER
                    Text("Dash Controls")
                        .foregroundStyle(.taskColor25)
                    
                    HStack {
                        Picker("Status", selection: $status) {
                            ForEach(Status.allCases) { status in
                                Text(status.descr).tag(status)
                            }
                        }.background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                            .pickerStyle(.menu)
                            .buttonStyle(.bordered)
                        //MARK:  TARGETS / TAGS
                        Button("Scope", systemImage: "scope") {
                            showTargetTags.toggle()
                        }
                        .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                        .sheet(isPresented: $showTargetTags) {
                            TargetTagView(objective: objective)
                        }
                        //MARK:  UPDATE BUTTON
                        NavigationLink {
                            UpdatesListView(objective: objective)
                        } label: {
                            let count = objective.updates?.count ?? 0
                            Label("\(count) Updates", systemImage: "square.and.pencil").fontDesign(.serif)
                        }.background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                        
                    }.background(.thinMaterial.shadow(.drop(color: .black.opacity(0.55), radius: 4)), in: .rect(cornerRadius: 7))
                        .buttonStyle(.bordered)
                        .padding(.horizontal, 7)
                    Divider()
                        .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                        .padding(10)
                    ScrollView {
                        VStack(alignment: .center, spacing: 7){
                            ///title
                            Text("Objective Title")
                                .foregroundStyle(.taskColor25)
                                .padding(.bottom, 4)
                            TextField("Objective Title", text:$title)
                                .padding()
                                .foregroundStyle(.primary)
                                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            ///description
                            Text("Brief Description")
                                .foregroundStyle(.taskColor25)
                            TextEditor(text: $summary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .foregroundStyle(.primary)
                                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 4)), in: .rect(cornerRadius: 7))
                                .frame(minWidth: 365, maxWidth: .infinity, minHeight: 85, maxHeight: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                            /// Giving Some Space for tapping
                                .padding(.horizontal)
                            //MARK:  DATE PICKERS
                            GroupBox{
                                LabeledContent {
                                    //MARK:  DATE ADDED BUTTON
                                    switch status {
                                        ///if in Queue - this date picker will present itself to the ui  - if changed to active or completed, then i want this other particular date picker to show its face.
                                    case .Queue:
                                        DatePicker("", selection: $dateAdded)
                                            .datePickerStyle(.compact)
                                            .scaleEffect(0.9, anchor: .leading)
                                    case .Active, .Completed:
                                        DatePicker("", selection: $dateAdded)
                                            .datePickerStyle(.compact)
                                            .scaleEffect(0.9, anchor: .leading)
                                    }
                                    
                                } label: {
                                    Text("Date Added")
                                }
                                if status == .Active || status == .Completed {
                                    LabeledContent {
                                        DatePicker("", selection: $dateStarted)
                                            .datePickerStyle(.compact)
                                            .scaleEffect(0.9, anchor: .leading)
                                    } label: {
                                        Text("Date Started")
                                    }
                                }
                                if status == .Completed {
                                    
                                    LabeledContent {
                                        DatePicker("", selection: $dateCompleted)
                                            .datePickerStyle(.compact)
                                            .scaleEffect(0.9, anchor: .leading)
                                    } label: {
                                        Text("Date Completed")
                                        
                                    }
                                }
                            }
                            .onChange(of: status) { oldValue, newValue in
                                if newValue == .Queue {
                                    dateStarted = Date.distantPast
                                    dateCompleted = Date.distantPast
                                } else if newValue == .Active && oldValue == .Completed {
                                    // from completed to inProgress
                                    dateCompleted = Date.distantPast
                                } else if newValue == .Active && oldValue == .Queue {
                                    // Book has been started
                                    dateStarted = Date.now
                                } else if newValue == .Completed && oldValue == .Queue {
                                    // Forgot to start objective
                                    dateCompleted = Date.now
                                    dateStarted = dateAdded
                                } else {
                                    // completed
                                    dateCompleted = Date.now
                                }
                            }
                            //MARK:  CUSTOM COLOR PICKER (OBJECTIVE COLOR)
                          
                            
                            
                            /// Giving Some Space for tapping
                            .padding(.horizontal)
                            
                            if let targetTags = objective.targetTags {
                                ViewThatFits {
                                    TargetTagsStackView(targetTags: targetTags)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        TargetTagsStackView(targetTags: targetTags)
                                    }
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                            }
                        }
                        .padding()
                        .navigationBarTitle("Edit Objective Folder")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    if changed {
                        Button{
                            HapticManager.notification(type: .success)
                            objective.status = status.rawValue
                            objective.title = title
                            objective.summary = summary
                            objective.dateAdded = dateAdded
                            objective.dateStarted = dateStarted
                            objective.dateCompleted = dateCompleted
                            dismiss()
                        }  label: {
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1))
                                
                                Text("Update Objective")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            
                        }.frame(width: 300, height: 55)
                            .buttonStyle(.borderedProminent)
                        
                    }
                }.padding(.top, 15)
                    .onAppear {
                        title = objective.title
                        summary = objective.summary
                        dateAdded = objective.dateAdded
                        dateStarted = objective.dateStarted
                        dateCompleted = objective.dateCompleted
                        
                        
                    }
            }
                var changed: Bool {
                    status != Status(rawValue: objective.status)!
                    || title != objective.title
                    || summary != objective.summary
                    || dateAdded != objective.dateAdded
                    || dateStarted != objective.dateStarted
                    || dateCompleted != objective.dateCompleted
                    
                }
            
        }
    }
}
#Preview {
    let preview = Preview(Objective.self)
   return  NavigationStack {
       EditObjectiveScreen(objective: Objective.sampleObjectives[4])
           .modelContainer(preview.container)
    }
}
