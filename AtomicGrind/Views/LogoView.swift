//
//  LogoView.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            HStack {
                Spacer()
                ZStack{
                    
                    Image(systemName: "atom")
                        .resizable()
                        .frame(width: 45, height: 40)
                        .foregroundColor(.blue).opacity(0.3)
                    HStack {
                        Text("Atomic")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            
                            .foregroundColor(.blue)
                            .offset(x: 8, y: -1)
                        Text("Grind")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.heavy)
                            .foregroundStyle(.primary)
                        Text("2")
                            .font(.caption)
                            .fontDesign(.serif)
                            .fontWeight(.regular)
                            .padding(.leading, 10)
                            .foregroundColor(.blue)
                            .offset(x: -16, y: -6)
                    }.offset(x: 5)
                     
                }
                Spacer()
                
            }
              
          
           
        }
    }
}
#Preview{
    LogoView()
}
