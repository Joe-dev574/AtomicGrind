//
//  ObjectiveSamples.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/22/24.
//

import Foundation

extension Objective {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleObjectives: [Objective] {
        [
            Objective(title: "QBVII",
                      summary: "Leon Uris", isComplete: true, objectiveTint: "taskColor20"),
            Objective(title: "Macbeth",
                 summary: "William Shakespear",
                 dateStarted: Date.now,
                      status: Status.Active, isComplete: false, objectiveTint: "taskColor1"),
            Objective(title: "Silence of the Grave",
                 summary: "Arnuldur Indrason, Bernard Scudder",
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                      status: Status.Completed, isComplete: false, objectiveTint: "taskColor2"),
            Objective(title: "Cardinal",
                      summary: "Giles Blunt", isComplete: false, objectiveTint: "taskColor3"),
            Objective(title: "Jackdaws",
                 summary: "Ken Follett",
                 dateStarted: Date.now,
                      status: Status.Active,
                      isComplete: false, objectiveTint: "taskColor4"),
               
            Objective(title: "Blackout",
                 summary: "John Lawton",
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                      status: Status.Completed, isComplete: false, objectiveTint: "taskColor6"),
            Objective(title: "The Sandman",
                      summary: "Lars Keplar", isComplete: false, objectiveTint: "taskColor7"),
            Objective(title: "The Redbreast",isComplete: false, objectiveTint:"taskColor8"),
            Objective(title: "Fatherland", summary: "Robert Harris", dateStarted: lastWeek,
                      status: Status.Completed, isComplete: false, objectiveTint: "taskColor18")
        ]
    }
}

