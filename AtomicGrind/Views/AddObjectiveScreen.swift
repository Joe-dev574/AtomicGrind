//
//  AddObjectiveScreen.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData


struct AddObjectiveScreen: View {
//MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title = ""
    @State private var summary = ""
    @State private var taskColor: String = "TaskColor 8"
    
    let columns = Array(repeating: GridItem(.fixed(50)), count: 6)
    var body: some View {
        NavigationStack {
            //MARK: FORM
            Form{
                VStack(alignment: .center, spacing: 7){
                    Text("Create New Objective")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.tintColor))
                        .font(.title3)
                        .padding(.leading, 15)
                        .padding(.bottom, 10)
                    Text("Objective Title")
                        .font(.caption)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    TextField("Objective Title", text:$title)
                        .padding()
                        .font(.headline)
                        .fontDesign(.serif)
                        .foregroundStyle(.black)
                        .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    Text("Brief Description")
                        .font(.caption)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    TextEditor(text: $summary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.headline)
                        .fontDesign(.serif)
                        .foregroundStyle(.black)
                        .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                        .frame(width: 350, height: 75)
                        .padding(.bottom, 10)
                    /// Giving Some Space for tapping
                        .padding(.horizontal)
                    //MARK:  CUSTOM COLOR PICKER (OBJECTIVE COLOR)
//                    Text("Objective Color")
//                        .fontDesign(.serif)
//                        .fontWeight(.bold)
//                        .font(.caption)
//                        .foregroundStyle(.blue)
//                    CustomColorPicker()
//                        .background(.background.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
//                        .padding()
                    Spacer( )
                }
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading, content: {
                            Button {
                                HapticManager.notification(type: .success)
                                dismiss()
                            } label: {
                                Text("Cancel")
                            }
                            .buttonStyle(.automatic)
                        })
                        ToolbarItem(placement: .principal, content: {
                            LogoView()
                        })
                        ToolbarItem(placement:.topBarTrailing, content: {
                            Button {
                                /// Saving Task
                                saveObjective()
                                HapticManager.notification(type: .success)
                                dismiss()
                            } label: {
                                Text("Save")
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(title.isEmpty || summary.isEmpty)
                            .padding(.horizontal, 2)
                        })
                    }
            }
            }
            
        }
//MARK: - Private Methods -
    private func saveObjective() {
        /// Saving Task
        let objective = Objective(title: title, summary: summary, isComplete: false, objectiveTint: taskColor)
        do {
            context.insert(objective)
            try context.save()
            /// After Successful Task Creation, Dismissing the View
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        HapticManager.notification(type: .success)
        dismiss()
        }
    }

    

