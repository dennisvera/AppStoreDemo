//
//  AppsSearchViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsSearchViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .red
  }

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
