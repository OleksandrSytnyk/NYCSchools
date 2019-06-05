//
//  UIViewController+HighScools.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit
import SVProgressHUD

// MARK: - Static HUD progress and messages support
extension UIViewController {
  static let successDismissTime: TimeInterval = 1.0
  
  static func stopHUD(afterBackgroundInteractionsDisabled: Bool = false) {
    SVProgressHUD.dismiss()
    
    if afterBackgroundInteractionsDisabled {
      UIViewController.setHUDbackgroundInteractions(disable: false)
    }
  }
  
  static func showHUD(shortDismissTime: Bool = false, disableBackgroundInteractions: Bool = false) {
    if disableBackgroundInteractions {
      UIViewController.setHUDbackgroundInteractions(disable: true)
    }
  }
  
  // NOTE: This function needs to be set before a HUD starts and set after a HUD stops since it will be the default setting.
  private static func setHUDbackgroundInteractions(disable: Bool) {
    SVProgressHUD.setDefaultMaskType(disable ? SVProgressHUDMaskType.black : SVProgressHUDMaskType.none)
  }
  
  func showErrorMessage(title: String, subTitle: String) {
    SVProgressHUD.showError(withStatus: title.localized + "\n" + subTitle.localized)
  }
}
