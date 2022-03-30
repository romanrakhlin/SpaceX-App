//
//  ContentView.swift
//  Shared
//
//  Created by Roman Rakhlin on 3/18/22.
//

import SwiftUI
import Combine

struct ContentView: View {

    @StateObject var viewModel = ViewModel()
    @State var spacecrafts: [Spacecraft] = []
    @State var notLoaded = true
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    Color.black
                    
                    if notLoaded == false {
                        TabView {
                            ForEach(spacecrafts, id: \.self) { spacecraft in
                                ScrollView(showsIndicators: false) {
                                        VStack(spacing: 0) {
                                            HeaderView(imageURL: spacecraft.flickrImages.randomElement()!)
                                            CardView(spacecraft: spacecraft)
                                        }
                                    }
                                }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .id(viewModel.spacecrafts.count)
                    } else {
                        VStack(alignment: .center) {
                            Spacer()
                            
                            Text("An Error Occurred! Check Your Internet Connection!")
                                .font(.custom("LabGrotesque-Regular", size: 14))
                                .foregroundColor(Color.init(hex: "#8E8E8F"))
                            
                            Spacer()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            viewModel.fetchSpacecrafts() { spacecrafts in
                if let goodSpacecrafts = spacecrafts {
                    self.spacecrafts = goodSpacecrafts
                    self.notLoaded = false
                } else {
                    self.notLoaded = true
                }
            }
        }
    }
}
