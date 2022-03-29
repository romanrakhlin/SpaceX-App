//
//  SliderData.swift
//  SpaceX Rockets (iOS)
//
//  Created by Roman Rakhlin on 3/29/22.
//

import SwiftUI

struct SliderData {
    let buttonRadius = 24.0
    let buttonMargin = 0.0
    let swipeVelocity = 0.45
    let swipeCancelThreshold = 0.15
    let waveMinLedge = 0.0
    let waveMinHR = 48.0
    let waveMinVR = 82.0

    let side: SliderSide
    let centerY: Double
    let progress: Double

    init(side: SliderSide) {
        self.init(side: side, centerY: side == .left ? 100 : 300, progress: 0)
    }

    init(side: SliderSide, centerY: Double, progress: Double) {
        self.side = side
        self.centerY = centerY
        self.progress = progress
    }

    var buttonOffset: CGSize {
        let sign = side == .left ? 1.0 : -1.0
        let hs = buttonRadius + buttonMargin
        return CGSize(width: waveLedgeX + sign * (waveHorizontalRadius - hs), height: centerY)
    }

    var buttonOpacity: Double {
        return max(1 - progress * 5, 0)
    }

    var waveLedgeX: Double {
        let ledge = waveMinLedge.interpolate(to: SliderData.width, in: progress, min: 0.2, max: 0.8)
        return side == .left ? ledge : SliderData.width - ledge
    }

    var waveHorizontalRadius: Double {
        let p1: Double = 0.4
        let to = SliderData.width * 0.8
        if progress <= p1 {
            return waveMinHR.interpolate(to: to, in: progress, max: p1)
        } else if progress >= 1 {
            return to
        }
        let t = (progress - p1) / (1 - p1)
        let m: Double = 9.8
        let beta: Double = 40.0 / (2 * m)
        let omega = pow(-pow(beta, 2) + pow(50.0 / m, 2), 0.5)
        return to * exp(-beta * t) * cos(omega * t)
    }

    var waveVerticalRadius: Double {
        return waveMinVR.interpolate(to: SliderData.height * 0.9, in: progress, max: 0.4)
    }

    func initial() -> SliderData {
        return SliderData(side: side, centerY: centerY, progress: 0)
    }

    func final() -> SliderData {
        return SliderData(side: side, centerY: centerY, progress: 1)
    }

    func drag(value: DragGesture.Value) -> SliderData {
        let dx = (side == .left ? 1 : -1) * Double(value.translation.width)
        let progress = min(1.0, max(0, dx * swipeVelocity / SliderData.width))
        return SliderData(side: side, centerY: Double(value.location.y), progress: progress)
    }

    func isCancelled(value: DragGesture.Value) -> Bool {
        return drag(value: value).progress < swipeCancelThreshold
    }

    static var width: Double {
        return Double(UIScreen.main.bounds.width)
    }

    static var height: Double {
        return Double(UIScreen.main.bounds.height)
    }
}
