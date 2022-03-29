//
//  ViewModel.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import Foundation
import Combine

// MARK: - DataModel
class ViewModel: ObservableObject {
    
    @Published var spacecrafts = Spacecrafts()
    
    let baseURL: String = "https://api.spacexdata.com/v4"
    
    func fetchSpacecrafts(completionHandler: @escaping (Spacecrafts?) -> Void) -> Void {
        guard let url = URL(string: baseURL + "/rockets") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let spacecrafts = try JSONDecoder().decode(Spacecrafts.self, from: data)
                completionHandler(spacecrafts)
            } catch {
                print(error)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchLaunches(spacecraftId: String, completionHandler: @escaping (Launches?) -> Void) -> Void {
        guard let url = URL(string: baseURL + "/launches") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let launches = try JSONDecoder().decode(Launches.self, from: data)
                var sorderLaunches: Launches = []
                
                for launch in launches {
                    if launch.rocket == spacecraftId {
                        sorderLaunches.append(launch)
                    }
                }
                
                completionHandler(sorderLaunches)
            } catch {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}
