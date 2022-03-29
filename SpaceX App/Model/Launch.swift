//
//  Launch.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/25/22.
//

import Foundation

typealias Launches = [Launch]

struct Launch: Codable, Hashable {
    
    let name: String
    let dateUTC: String
    let rocket: String
    let success: Bool?
    
    var getDateUTC: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: dateUTC[0..<10]) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "-"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case dateUTC = "date_utc"
        case rocket
        case success
    }
}
