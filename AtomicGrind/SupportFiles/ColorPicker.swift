//
//  ColorPicker.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData

struct CustomColorPicker: View {
    @Environment(\.modelContext) private var context
    
    @State private var objectiveTint: String = " "
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 30, maximum: 300), spacing: nil , alignment: nil )]
    
    let colors: [String] = (1...30).compactMap { index -> String in
                    return "TaskColor\(index)"
                }
                

    var body: some View {
        VStack(alignment: .center, spacing: 10){
    //MARK:  COLOR PICKER
                
                LazyVGrid(columns: columns){
                    ForEach(colors, id: \.self) { color in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(color).gradient)
                                .frame(height: 36)
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 10 )
                                        .stroke(lineWidth: 5)
                                        .opacity(objectiveTint == color ? 1 : 0)
                                        .frame(width: 37, height: 37)
                                })
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        HapticManager.notification(type: .success)
                                        objectiveTint = color
                                    }
                                }
                        }
                    }
                 
                }
            }
        .frame( height: 170, alignment: .center)
            }
        }
   
#Preview {
    CustomColorPicker()
}
