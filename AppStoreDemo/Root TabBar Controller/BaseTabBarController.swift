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

    viewControllers = [
      createNavigationControllers(viewController: MusicCollectionViewController(), title: "Music", imageName: "music_icon"),
      createNavigationControllers(viewController: TodayCollectionViewController(), title: "", imageName: "todayIcon"),
      createNavigationControllers(viewController: AppsCollectionViewController(), title: "Apps", imageName: "appsIcon"),
      createNavigationControllers(viewController: SearchCollectionViewController(), title: "Search", imageName: "searchIcon")
    ]
  }

  fileprivate func createNavigationControllers(viewController: UIViewController,
                                               title: String,
                                               imageName: String) -> UIViewController {

    viewController.view.backgroundColor = .white
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.title = title
    navigationController.tabBarItem.image = UIImage(named: imageName)
    navigationController.navigationBar.prefersLargeTitles = true

    return navigationController
  }
}
