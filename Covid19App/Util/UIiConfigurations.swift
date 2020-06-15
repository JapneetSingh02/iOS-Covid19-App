//
//  UIiConfigurations.swift
//  Covid19App
//
//  Created by Student on 2020-04-21.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import Foundation
import UIKit

class UiConfigurations{
    
    static func updateUiElements(_ uiView : UIView...) {
        
        // inspiration taken from stackoverflow.com
        for view in uiView{
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: -1, height: 1)
            view.layer.shadowRadius = 5
            view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
