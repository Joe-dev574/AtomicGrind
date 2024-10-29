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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(.ultraThickMaterial)
            VStack(alignment: .leading){
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.ultraThinMaterial)
                            .frame(height: 30)
                        ZStack{
                            RoundedRectangle(cornerRadius: 7)
                                .fill(.darkBlue)
                                .frame(height: 30)
                            RoundedRectangle(cornerRadius: 7)
                                .fill(.backgroundGray)
                                .opacity(0.55)
                                .frame(height: 35)
                        }
                        .foregroundStyle(.primary)
                    }
                }
                //MARK:  MAIN BODY OF CARD
                HStack{
                    //MARK:  ICON
                    objective.icon
                        .font(.title)
                    VStack(alignment: .leading){
                        Text(objective.title )
                            .ubuntu(21, .bold)
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 2)
                        Text(objective.summary)
                            .ubuntu(17, .bold)
                            .foregroundColor(.blue)
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
                        }
                    }
                }
            }
                .padding(.horizontal,2)
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
        }
    }

