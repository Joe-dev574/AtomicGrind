//
//  TargetTag.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/21/24.
//

import SwiftUI
import SwiftData

@Model
class TargetTag {
    var name: String = ""
    var color: String = "FF0000"
    var objectives: [Objective]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
