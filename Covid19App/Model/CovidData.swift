//
//  CovidData.swift
//  Covid19App
//
//  Created by Student on 2020-04-15.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import Foundation
import CoreLocation


struct CovidData: Codable{
    let id, displayName: String
    let areas: [CovidData]
    let totalConfirmed: Int
    let totalDeaths, totalRecovered : Int?
    let lat, long: Double?
    let parentID: String?
    
    func getCLLocation() -> CLLocation {
        if let lat = lat {
            if let long = long {
                return CLLocation(latitude: lat, longitude: long)
            }
        }
        return CLLocation()
    }
    
    func getTotalDeaths() -> Int {
        if let totalDeaths = totalDeaths {
            return totalDeaths
        }
        else {
            return 0
        }
    }
    func getTotalRecovered() -> Int {
        if let totalRecovered = totalRecovered {
            return totalRecovered
        }
        else {
            return 0
        }
    }
    
}
