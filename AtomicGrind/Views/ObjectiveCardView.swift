//
//  ObjectiveCardView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/21/24.
//

import SwiftUI
import SwiftData



struct ObjectiveCardView: View {
    let objective: Objective
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack {
                    VStack(alignment: .center){
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 30)
                                HStack {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(.blue)
                                            .frame(width: 58, height: 28)
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(.cyan)
                                            .frame(width: 55, height: 25)
                                        Text("Ozark")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .fontDesign(.serif)
                                            .foregroundStyle(.black)
                                    }.padding(.horizontal, 10)
                                    Spacer( )
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        Text(objective.title)
                            .font(.title3)
                            .fontDesign(.serif)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 7)
                            .padding(.top, 1)
                        Text(objective.summary)
                            .font(.caption)
                            .fontDesign(.serif)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 7)
                            .padding(.bottom, 40)
                            .lineLimit(1)
                        HStack {
                            Text("Date Created: ")
                                .fontDesign(.serif)
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Image(systemName: "calendar.badge.clock")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            Text(objective.timestamp.formatted(.dateTime))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }.padding(.top, -10)
                    }.padding(.horizontal, 10)
                    Spacer( )
                }
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                
                
            }.padding(.horizontal, 1)
                .padding(.top, 5)
            
        }.padding(.horizontal)
        
    }
    
}
