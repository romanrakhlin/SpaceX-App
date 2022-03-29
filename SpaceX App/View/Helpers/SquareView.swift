//
//  SquareView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import SwiftUI

struct SquareView: View {
    
    var value: String
    var kind: String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("\(value)")
                    .font(.custom("LabGrotesque-Bold", size: 16))
                Text(kind)
                    .font(.custom("LabGrotesque-Regular", size: 14))
                    .foregroundColor(Color.init(hex: "#8E8E8F"))
            }
            .foregroundColor(Color.white)
            .frame(width: 96, height: 96)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(32)
        }
    }
}
