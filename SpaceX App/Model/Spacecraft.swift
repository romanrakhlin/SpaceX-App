//
//  Food.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import Foundation

typealias Spacecrafts = [Spacecraft]

struct Spacecraft: Codable, Hashable {
    
    let height: MeasureSize
    let diameter: MeasureSize
    let mass: MeasureWeight
    
    let firstStage: Stage
    let secondStage: Stage
    
    let flickrImages: [String]
    
    let name: String
    let type: String
    let costPerLaunch: Int
    let firstFlight: String
    let country: String
    
    let payloadWeights: [MeasureWeight]
    
    let id: String
    
    // Computed Properties
    var getPayloadWeight: (String, String) {
        let payloadWeightIsLb = UserDefaults.standard.bool(forKey: "payloadWeightIsLb")
        
        if payloadWeightIsLb {
            return ("\(payloadWeights[0].lb)", "Полезная нагрузка, lb")
        } else {
            return ("\(payloadWeights[0].kg)", "Полезная нагрузка, kg")
        }
    }
    
    var getFirstFlightDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: firstFlight) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "-"
        }
    }
    
    var getPrice: String {
        return costPerLaunch.roundedWithAbbreviations
    }
    
    enum CodingKeys: String, CodingKey {
        case height
        case diameter
        case mass
        
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        
        case flickrImages = "flickr_images"
        
        case name
        case type
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country
        
        case payloadWeights = "payload_weights"
        
        case id
    }
}

struct MeasureSize: Codable, Hashable {
    let meters: Double
    let feet: Double
}

struct MeasureWeight: Codable, Hashable {
    let kg: Double
    let lb: Double
}

struct Stage: Codable, Hashable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int?
    
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}
