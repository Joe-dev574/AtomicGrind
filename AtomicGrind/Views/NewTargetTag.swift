//
//  NewTargetTag.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/31/24.
//

import SwiftData
import SwiftUI

struct NewTargetTag: View {
    @State private var name = ""
    @State private var color = Color.red
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
               
                ColorPicker("Set the tag color", selection: $color, supportsOpacity: false)
                Button("Create") {
                    let newTargetTag = TargetTag(name: name, color: color.toHexString()!)
                    context.insert(newTargetTag)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("New Tag")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewTargetTag()
}
