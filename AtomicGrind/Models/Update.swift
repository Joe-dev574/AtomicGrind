//
//  ActivityUpdate.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/21/24.
//

import Foundation
import SwiftData

@Model
class Update {
    var creationDate: Date = Date.now
    var text: String = ""
    var page: String? = ""
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    
    var objective: Objective?
}

