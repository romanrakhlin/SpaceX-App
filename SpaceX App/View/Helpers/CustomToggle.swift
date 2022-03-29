//
//  CustomToggle.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/25/22.
//

import SwiftUI

struct CustomToggle: ToggleStyle {
    
    let firstMeasute: String
    let secondMeasure: String
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label

            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 115, height: 40)
                        .foregroundColor(Color(hex: "#212121"))
                    
                    HStack(alignment: .center, spacing: 40) {
                        Text(firstMeasute)
                        Text(secondMeasure)
                    }
                    .font(.custom("LabGrotesque-Bold", size: 14))
                    .foregroundColor(Color.init(hex: "#8E8E8F"))
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 56, height: 34)
                        .padding(3)
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation {
                                configuration.$isOn.wrappedValue.toggle()
                            }
                        }
                    
                    Text(configuration.isOn ? secondMeasure : firstMeasute)
                        .font(.custom("LabGrotesque-Bold", size: 14))
                        .foregroundColor(Color.init(hex: "#121212"))
                }
            }
        }
    }
}
