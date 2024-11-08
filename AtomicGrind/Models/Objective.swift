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
    var dateAdded: Date = Date.now
    var title: String = ""
    var summary: String = ""
    var dateStarted: Date = Date.distantPast
    var dateCompleted: Date = Date.distantPast
    var status: Status.RawValue = Status.Active.rawValue
    var isComplete: Bool = false
    var objectiveTint: String
    @Relationship(deleteRule: .cascade)
    var updates: [Update]?
    @Relationship(inverse: \TargetTag.objectives)
    var targetTags: [TargetTag]?
//    @Relationship(deleteRule: .cascade)
//    var tasks: [Task]?
    init(
        dateAdded: Date = Date.now,
        title: String = "",
        summary: String = "",
        dateStarted: Date = Date .distantPast,
        dateCompleted: Date = Date.distantPast,
        status: Status = .Active,
        isComplete: Bool,
        objectiveTint: String,
        targetTags: [TargetTag]? = nil
    ) {
        self.dateAdded = dateAdded
        self.title = title
        self.summary = summary
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.status = status.rawValue
        self.isComplete = isComplete
        self.objectiveTint = objectiveTint
        self.targetTags = targetTags
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Queue:
            Image(systemName: "pause.circle")
               
        case .Active:
            Image(systemName: "play.circle")
        case .Completed:
            Image(systemName: "stop.circle")
        }
    }
    var tintColor: Color {
        switch objectiveTint {
            case "TaskColor 1": return .taskColor1
            case "TaskColor 2": return .taskColor2
            case "TaskColor 3": return .taskColor3
            case "TaskColor 4": return .taskColor4
            case "TaskColor 5": return .taskColor5
            case "TaskColor 6": return .taskColor6
            case "TaskColor 7": return .taskColor7
            case "TaskColor 8": return .taskColor8
            case "TaskColor 9": return .taskColor9
            case "TaskColor 10": return .taskColor10
            case "TaskColor 11": return .taskColor11
            case "TaskColor 12": return .taskColor12
            case "TaskColor 13": return .taskColor13
            case "TaskColor 14": return .taskColor14
            case "TaskColor 15": return .taskColor15
            case "TaskColor 16": return .taskColor16
            case "TaskColor 17": return .taskColor17
            case "TaskColor 18": return .taskColor18
            case "TaskColor 19": return .taskColor19
            case "TaskColor 20": return .taskColor20
            case "TaskColor 21": return .taskColor21
        default: return .black
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


