//
//  LaunchesView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/26/22.
//

import SwiftUI

struct LaunchesView: View {
    
    let spacecraftName: String
    let spacecraftId: String
    
    @StateObject var viewModel = ViewModel()
    @State var launches: Launches? = []
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 10, height: 16, alignment: .center)
                                .foregroundColor(Color.white)
                            
                            Text("Назад")
                                .font(.custom("LabGrotesque-Medium", size: 16))
                                .foregroundColor(Color.white)
                        })
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(spacecraftName)
                            .font(.custom("LabGrotesque-Bold", size: 16))
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.top, 24)
                .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 16) {
                        if let goodLaunches = launches {
                            if goodLaunches.count != 0 {
                                ForEach(goodLaunches, id: \.self) { launch in
                                    HStack(alignment: .center) {
                                        VStack(alignment: .leading) {
                                            Text(launch.name)
                                                .font(.custom("LabGrotesque-Bold", size: 20))
                                                .foregroundColor(Color.init(hex: "#FFFFFF"))
                                            Text(launch.getDateUTC)
                                                .font(.custom("LabGrotesque-Regular", size: 16))
                                                .foregroundColor(Color.init(hex: "#8E8E8F"))
                                        }
                    
                                        Spacer()
                                        
                                        if let success = launch.success {
                                            Image(success ? "success" : "failure")
                                                .resizable()
                                                .frame(width: 32, height: 32, alignment: .center)
                                        } else {
                                            Image("unknown")
                                                .resizable()
                                                .frame(width: 32, height: 32, alignment: .center)
                                        }
                                    }
                                    .padding(24)
                                    .background(Color(hex: "#212121"))
                                    .cornerRadius(24)
                                }
                            } else {
                                Text("The Rocket Has Never Neen Launched!")
                                    .font(.custom("LabGrotesque-Regular", size: 14))
                                    .foregroundColor(Color.init(hex: "#FFFFFF"))
                            }
                        } else {
                            Text("An Error Occurred! Check Your Internet Connection!")
                                .font(.custom("LabGrotesque-Regular", size: 14))
                                .foregroundColor(Color.init(hex: "#8E8E8F"))
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 32)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetchLaunches(spacecraftId: spacecraftId) { fetchedLaunches in
                self.launches = fetchedLaunches
            }
        }
    }
}
