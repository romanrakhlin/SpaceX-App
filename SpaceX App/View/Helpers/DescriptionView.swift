//
//  DescriptionView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import SwiftUI

struct DescriptionView: View {
    
    var kind: String
    var value: String
    
    var body: some View {
        HStack {
            Text(kind)
                .font(.custom("LabGrotesque-Regular", size: 16))
                .foregroundColor(Color.init(hex: "#CACACA"))
            
            Spacer()
            
            Text(value)
                .font(.custom("LabGrotesque-Regular", size: 16))
                .foregroundColor(Color.init(hex: "#F6F6F6"))
        }
    }
}
