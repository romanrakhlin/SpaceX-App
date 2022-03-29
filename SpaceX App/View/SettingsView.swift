//
//  SettingsView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/25/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var heightIsFt: Bool
    @Binding var diameterIsFt: Bool
    @Binding var massIsLb: Bool
    @Binding var payloadWeightIsLb: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(hex: "#121212")
            
            VStack {
                ZStack {
                    HStack {
                        Text("Настройки")
                            .font(.custom("LabGrotesque-Medium", size: 16))
                            .foregroundColor(Color.white)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // saving parametrs
                            UserDefaults.standard.set(heightIsFt, forKey: "heightIsFt")
                            UserDefaults.standard.set(diameterIsFt, forKey: "diameterIsFt")
                            UserDefaults.standard.set(massIsLb, forKey: "massIsLb")
                            UserDefaults.standard.set(payloadWeightIsLb, forKey: "payloadWeightIsLb")
                            
                            dismiss()
                        }, label: {
                            Text("Закрыть")
                                .font(.custom("LabGrotesque-Bold", size: 16))
                                .foregroundColor(Color.white)
                        })
                    }
                }
                .padding(.top, 24)
            
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Высота")
                            .font(.custom("LabGrotesque-Medium", size: 16))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Toggle("", isOn: $heightIsFt)
                    }
                    .toggleStyle(CustomToggle(firstMeasute: "m", secondMeasure: "ft"))
                    
                    HStack {
                        Text("Диаметр")
                            .font(.custom("LabGrotesque-Medium", size: 16))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Toggle("", isOn: $diameterIsFt)
                    }
                    .toggleStyle(CustomToggle(firstMeasute: "m", secondMeasure: "ft"))
                    
                    HStack {
                        Text("Масса")
                            .font(.custom("LabGrotesque-Medium", size: 16))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Toggle("", isOn: $massIsLb)
                    }
                    .toggleStyle(CustomToggle(firstMeasute: "kg", secondMeasure: "lb"))
                    
                    HStack {
                        Text("Полезная нагрузка")
                            .font(.custom("LabGrotesque-Medium", size: 16))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Toggle("", isOn: $payloadWeightIsLb)
                    }
                    .toggleStyle(CustomToggle(firstMeasute: "kg", secondMeasure: "lb"))
                }
                .padding(.top, 62)
                
                 Spacer()
            }
            .padding(.horizontal, 24)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
