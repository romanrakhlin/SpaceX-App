//
//  String+Extension.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/26/22.
//

import Foundation

// For LaunchesView
/// the date of launch has really weird format so we have to slice it, and keep only first 9 characters.
/// This exension helps really easy slice the string
extension String {
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
