//
//  TargetTagsStackView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/22/24.
//

import SwiftUI

struct TargetTagsStackView: View {
    var targetTags: [TargetTag]
    var body: some View {
        HStack {
            ForEach(targetTags.sorted(using: KeyPathComparator(\TargetTag.name))) { targetTag in
                Text(targetTag.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).fill(targetTag.hexColor))
            }
        }
    }
}
