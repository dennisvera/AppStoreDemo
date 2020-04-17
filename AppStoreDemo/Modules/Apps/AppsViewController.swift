//
//  AppsViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsViewController: UICollectionViewController {

  // MARK: - Properties

  fileprivate let cellId = "AppsCellId"

  // MARK: - Initialization

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = .blue
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
}

extension AppsViewController: UICollectionViewDelegateFlowLayout {

  // MARK: - CollectionView Delegate

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: view.frame.width, height: 350)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                  for: indexPath) as! AppsGroupCollectionViewCell

    return cell
  }
}
