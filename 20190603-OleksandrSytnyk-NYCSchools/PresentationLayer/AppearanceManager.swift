//
//  AppearanceManager.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/10/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class AppearanceManager {
  
  class func customizeAppearance() {
    let barTintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255,
                               alpha: 1)
    let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
    
    UINavigationBar.appearance().barTintColor = barTintColor
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = attributes
  }
  
}
