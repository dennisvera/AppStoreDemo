//
//  AppsHorizontalViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsHorizontalViewController: UICollectionViewController {

  // MARK: - Properties

  let cellIdentifier = "cellId"

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

    // Register Collection View Cell
    collectionView.register(AppsRowCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.backgroundColor = .white

    // Set Collection View Scroll Direction
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
  }
}

extension AppsHorizontalViewController: UICollectionViewDelegateFlowLayout {

  // MARK: - CollectionView Delegate

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath) as! AppsRowCollectionViewCell

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionLineSpacing: CGFloat = 20
    let sectionInsetTopBottomPadding: CGFloat = 24
    let height = (view.frame.height - sectionInsetTopBottomPadding - sectionLineSpacing) / 3
    
    return .init(width: view.frame.width - 48, height: height)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {

    return 10
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

    return .init(top: 12, left: 16, bottom: 12, right: 16)
  }
}
