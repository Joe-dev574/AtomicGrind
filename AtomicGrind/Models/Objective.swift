//
//  Objective.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData

@Model
final class Objective {
    var timestamp: Date = Date.now
    var title: String = ""
    var summary: String = ""
    var dateStarted: Date = Date.distantPast
    var dateCompleted: Date = Date.distantPast
    var status: Status.RawValue = Status.Active.rawValue
    var isComplete: Bool = false
    @Relationship(deleteRule: .cascade)
    var activityUpdate: [ActivityUpdate]?
    @Relationship(inverse: \TargetTag.objectives)
    var targetTags: [TargetTag]?
    
    init(
        timestamp: Date = Date.now,
        title: String = "",
        summary: String = "",
        dateStarted: Date = Date .distantPast,
        dateCompleted: Date = Date.distantPast,
        status: Status = .Active,
        isComplete: Bool,
        activityUpdate: [ActivityUpdate]? = nil,
        targetTags: [TargetTag]? = nil
    ) {
        self.timestamp = timestamp
        self.title = title
        self.summary = summary
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.status = status.rawValue
        self.isComplete = isComplete
        self.activityUpdate = activityUpdate
        self.targetTags = targetTags
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Queue:
            Image(systemName: "checkmark.diamond.fill")
        case .Active:
            Image(systemName: "book.fill")
        case .Completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case Queue, Active, Completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .Queue:
            "Queue"
        case .Active:
            "Active"
        case .Completed:
            "Completed"
        }
    }
}


