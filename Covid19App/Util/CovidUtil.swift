//
//  CovidUtil.swift
//  Covid19App
//
//  Created by Student on 2020-04-21.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import Foundation

class CovidUtil{
    
    // inspiration taken from stackoverflow.com
    static func numberFormatter() -> NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
}
