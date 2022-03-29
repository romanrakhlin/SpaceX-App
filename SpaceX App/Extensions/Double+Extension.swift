//
//  Double+Extension.swift
//  SpaceX Rockets (iOS)
//
//  Created by Roman Rakhlin on 3/29/22.
//

import Foundation

extension Double {
    func interpolate(to: Double, in fraction: Double, min: Double = 0, max: Double = 1) -> Double {
        if fraction <= min {
            return self
        } else if fraction >= max {
            return to
        }
        return self + (to - self) * (fraction - min) / (max - min)
    }
}
