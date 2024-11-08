//
//  ObjectiveCardView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/21/24.
//

import SwiftUI
import SwiftData



struct ObjectiveCardView: View {
    //MARK:  PROPERTIES
    let objective: Objective
    @State private var showEditObjectiveScreen: Bool = false
    var body: some View {
        NavigationStack{
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack(alignment: .leading){
                    HStack{
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(.ultraThinMaterial)
                                .frame(height: 30)
                        }
                     
                    }
                    //MARK:  MAIN BODY OF CARD
                    HStack{
                        //MARK:  ICON
                        objective.icon
                            .font(.title)
                            .padding(.leading, 5)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 30)
                        VStack(alignment: .leading){
                            Text(objective.title )
                                .ubuntu(21, .bold)
                                .foregroundStyle(.primary)
                                .padding(.horizontal, 2)
                            Text(objective.summary)
                                .ubuntu(17, .bold)
                                .foregroundStyle(.blue)
                                .padding(.horizontal, 4)
                                .padding(.bottom, 10)
                                .lineLimit(3)
                            HStack {
                                //MARK:  DATE CREATED DATA LINE
                                Text("Date Created: ")
                                    .ubuntu(12, .bold)
                                    .foregroundStyle(.gray)
                                Image(systemName: "calendar.badge.clock")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Text(objective.dateAdded.formatted(.dateTime))
                                    .ubuntu(12, .bold)
                                    .foregroundColor(.secondary)
                            }.padding(.top, 5)
                                .padding(.bottom, 3)
                            HStack {
                                //MARK:  DATE CREATED DATA LINE
                                Text("Date Started: ")
                                    .ubuntu(12, .bold)
                                    .foregroundStyle(.teal)
                                Image(systemName: "calendar.badge.clock")
                                    .font(.caption)
                                    .foregroundStyle(.teal)
                                Text(objective.dateStarted.formatted(.dateTime))
                                    .ubuntu(12, .bold)
                                    .foregroundStyle(.teal)
                            }.padding(.bottom, 5)
                            if let targetTags = objective.targetTags {
                                ViewThatFits {
                                    TargetTagsStackView(targetTags: targetTags)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        TargetTagsStackView(targetTags: targetTags)
                                    }
                                }
                            }
                        }
                    }
                  
                }
            }
          
        }
    }
}
