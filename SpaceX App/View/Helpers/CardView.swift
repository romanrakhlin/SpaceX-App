//
//  CardView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import SwiftUI

struct CardView: View {
    
    let spacecraft: Spacecraft
    
    // sheets
    @State private var showingSettings = false
    @State private var showingLaunches = false
    
    // parametrs
    @State var heightIsFt = UserDefaults.standard.bool(forKey: "heightIsFt")
    @State var diameterIsFt = UserDefaults.standard.bool(forKey: "diameterIsFt")
    @State var massIsLb = UserDefaults.standard.bool(forKey: "massIsLb")
    @State var payloadWeightIsLb = UserDefaults.standard.bool(forKey: "payloadWeightIsLb")
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(spacecraft.name)
                        .font(.custom("LabGrotesque-Bold", size: 24))
                        .foregroundColor(Color.init(hex: "#F6F6F6"))
                    
                    Spacer()

                    Button {
                        showingSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 28, height: 28, alignment: .center)
                            .foregroundColor(Color.init(hex: "#CACACA"))
                    }
                    .sheet(isPresented: $showingSettings) {
                        SettingsView(heightIsFt: $heightIsFt, diameterIsFt: $diameterIsFt, massIsLb: $massIsLb, payloadWeightIsLb: $payloadWeightIsLb)
                    }
                }
                .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        SquareView(value: heightIsFt ? "\(spacecraft.height.feet)" : "\(spacecraft.height.meters)", kind: heightIsFt ? "Высота, ft" : "Высота, m")
                        SquareView(value: diameterIsFt ? "\(spacecraft.diameter.feet)" : "\(spacecraft.diameter.meters)", kind: diameterIsFt ? "Диаметр, ft" : "Диаметр, m")
                        SquareView(value: massIsLb ? "\(spacecraft.mass.lb)" : "\(spacecraft.mass.kg)", kind: massIsLb ? "Масса, lb" : "Масса, kg")
                        SquareView(value: payloadWeightIsLb ? "\(spacecraft.height.feet)" : "\(spacecraft.height.meters)", kind: payloadWeightIsLb ? "Полезная нагрузка, lb" : "Полезная нагрузка, kg")
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 30)

                // Details
                VStack(alignment: .leading, spacing: 40) {
                    VStack(spacing: 16) {
                        DescriptionView(kind: "Перывый запуск", value: spacecraft.getFirstFlightDate)
                        DescriptionView(kind: "Страна", value: spacecraft.country)
                        DescriptionView(kind: "Стоимость запуска", value: spacecraft.getPrice)
                    }

                    // First
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ПЕРВАЯ СТУПЕНЬ")
                            .font(.custom("LabGrotesque-Bold", size: 16))
                            .foregroundColor(Color.init(hex: "#F6F6F6"))

                        VStack(spacing: 16) {
                            DescriptionView(kind: "Количество двигателей", value: "\(spacecraft.firstStage.engines)")
                            DescriptionView(kind: "Количетсво топлива", value: "\(spacecraft.firstStage.fuelAmountTons)")
                            DescriptionView(kind: "Время сгорания", value: (spacecraft.firstStage.burnTimeSec != nil) ? "\(spacecraft.firstStage.burnTimeSec!)" : "-") // weird one-liner I know)))
                        }
                    }

                    // Second
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ВТОРАЯ СТУПЕНЬ")
                            .font(.custom("LabGrotesque-Bold", size: 16))
                            .foregroundColor(Color.init(hex: "#F6F6F6"))

                        VStack(spacing: 16) {
                            DescriptionView(kind: "Количество двигателей", value: "\(spacecraft.secondStage.engines)")
                            DescriptionView(kind: "Количетсво топлива", value: "\(spacecraft.secondStage.fuelAmountTons)")
                            DescriptionView(kind: "Время сгорания", value: (spacecraft.secondStage.burnTimeSec != nil) ? "\(spacecraft.secondStage.burnTimeSec!)" : "-")
                        }
                    }

                    // Button
                    Button {
                        showingLaunches.toggle()
                    } label: {
                        HStack {
                            Spacer()

                            Text("Посмотреть запуски")
                                .font(.custom("LabGrotesque-Bold", size: 16))
                                .foregroundColor(Color.init(hex: "#F6F6F6"))
                                .padding()

                            Spacer()
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(16)
                    }
                    .sheet(isPresented: $showingLaunches) {
                        LaunchesView(spacecraftName: spacecraft.name, spacecraftId: spacecraft.id)
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
        .padding(.top, 40)
        .background(Color.black)
        .cornerRadius(32)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
