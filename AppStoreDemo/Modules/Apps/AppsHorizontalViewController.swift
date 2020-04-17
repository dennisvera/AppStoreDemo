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

  let cellId = "cellId"

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

      collectionView.backgroundColor = .lightGray
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

      if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
        layout.scrollDirection = .horizontal
      }
    }
  }

extension AppsHorizontalViewController: UICollectionViewDelegateFlowLayout {

  // MARK: - CollectionView Delegate

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Set the search term label if count is 0

    return 5
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .cyan

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionLineSpacing = 20
    let sectionInsetTopAndBottom = 24
    let height = (view.frame.height - sectionInsetTopAndBottom - sectionLineSpacing) / 3

    return .init(width: view.frame.width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 12, left: 16, bottom: 12, right: 16)
  }

}
