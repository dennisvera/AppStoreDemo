//
//  BaseTabBarController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let redViewController = UIViewController()
    redViewController.view.backgroundColor = .white
    redViewController.navigationItem.title = "Apps"

    let redNavBarController = UINavigationController(rootViewController: redViewController)
    redNavBarController.tabBarItem.title = "Apps"
    redNavBarController.tabBarItem.image = #imageLiteral(resourceName: "apps")
    redNavBarController.navigationBar.prefersLargeTitles = true

    let blueViewController = UIViewController()
    blueViewController.view.backgroundColor = .white
    blueViewController.navigationItem.title = "Search"

    let blueNavBarController = UINavigationController(rootViewController: blueViewController)
    blueNavBarController.tabBarItem.title = "Search"
    blueNavBarController.tabBarItem.image = #imageLiteral(resourceName: "search")
    blueNavBarController.navigationBar.prefersLargeTitles = true

    viewControllers = [
      redNavBarController,
      blueNavBarController
    ]
  }
}
