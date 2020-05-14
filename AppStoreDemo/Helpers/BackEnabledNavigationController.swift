//
//  BackEnabledNavigationController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/14/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
  
  // MARK: - Initialization
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Enable back swipe gesture
    self.interactivePopGestureRecognizer?.delegate = self
  }
  
  // MARK: - Helper Methods
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    // Enable back gesture if there are more than one controller
    return self.viewControllers.count > 1
  }
}
