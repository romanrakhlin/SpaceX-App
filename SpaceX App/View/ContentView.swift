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

    // Slider setup
    @State var pageIndex = 0
    @State var topSlider = SliderSide.right
    @State var sliderOffset: CGFloat = 0
    
    @State var leftData = SliderData(side: .left)
    @State var rightData = SliderData(side: .right)
    
    let arrowWidth = 4
    let arrowHeight = 12.0
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    Color.black
                    
                    if notLoaded == false {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                HeaderView(imageURL: self.spacecrafts[pageIndex].flickrImages[0])
                                CardView(spacecraft: spacecrafts[pageIndex])
                            }
                        }
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
        
            if notLoaded == false {
                slider(data: $leftData)
                slider(data: $rightData)
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

// MARK: - For Custom SLider
extension ContentView {
    
    func slider(data: Binding<SliderData>) -> some View {
        let value = data.wrappedValue
        return ZStack {
            wave(data: data)
            button(data: value)
        }
        .zIndex(topSlider == value.side ? 1 : 0)
        .offset(x: value.side == .left ? -sliderOffset : sliderOffset)
    }

    func button(data: SliderData) -> some View {
        let aw = (data.side == .left ? 1 : -1) * arrowWidth / 2
        let ah = arrowHeight / 2
        return ZStack {
            circle(radius: 24).opacity(0.2)
            polyline(-Double(aw), -ah, Double(aw), 0, -Double(aw), ah).stroke(Color.white, lineWidth: 2)
        }
        .offset(data.buttonOffset)
        .opacity(data.buttonOpacity)
    }

    func wave(data: Binding<SliderData>) -> some View {
        let gesture = DragGesture().onChanged {
            self.topSlider = data.wrappedValue.side
            data.wrappedValue = data.wrappedValue.drag(value: $0)
        }
        .onEnded {
            if data.wrappedValue.isCancelled(value: $0) {
                withAnimation(.spring(dampingFraction: 0.5)) {
                    data.wrappedValue = data.wrappedValue.initial()
                }
            } else {
                self.swipe(data: data)
            }
        }
        .simultaneously(with: TapGesture().onEnded {
            self.topSlider = data.wrappedValue.side
            self.swipe(data: data)
        })
        return WaveView(data: data.wrappedValue)
            .gesture(gesture)
            .foregroundColor(Color.black.opacity(0.8))
    }

    private func swipe(data: Binding<SliderData>) {
        withAnimation() {
            data.wrappedValue = data.wrappedValue.final()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.pageIndex = self.index(of: data.wrappedValue)
            self.leftData = self.leftData.initial()
            self.rightData = self.rightData.initial()

            self.sliderOffset = 100
            withAnimation(.spring(dampingFraction: 0.5)) {
                self.sliderOffset = 0
            }
        }
    }

    private func index(of data: SliderData) -> Int {
        let last = spacecrafts.count - 1
        if data.side == .left {
            return pageIndex == 0 ? last : pageIndex - 1
        } else {
            return pageIndex == last ? 0 : pageIndex + 1
        }
    }

    private func circle(radius: Double) -> Path {
        return Path { path in
            path.addEllipse(in: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2))
        }
    }

    private func polyline(_ values: Double...) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: values[0], y: values[1]))
            for i in stride(from: 2, to: values.count, by: 2) {
                path.addLine(to: CGPoint(x: values[i], y: values[i + 1]))
            }
        }
    }
}
