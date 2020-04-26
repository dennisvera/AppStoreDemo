//
//  AppsDetailCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/26/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsDetailCollectionViewController: UICollectionViewController {

  // MARK: - Initilaization

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .yellow
  }
}
