//
//  RootViewController.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 12/03/2024.
//

import SwiftUI
import Foundation

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }

  var rootViewController: UIViewController? {
    currentKeyWindow?.rootViewController
  }
}
