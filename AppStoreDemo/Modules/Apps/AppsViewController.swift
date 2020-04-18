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

  fileprivate let cellIdentifier = "AppsCellId"
  fileprivate let headerIdentification = "HeaderId"

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

    registerCollectionView()
  }

  fileprivate func registerCollectionView() {
    // Register Collection View Cell
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.backgroundColor = .white

    // Register Collection Header View
    collectionView.register(AppsHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: headerIdentification)
  }
}

// MARK: - CollectionView Delegate Flow Layout

extension AppsViewController: UICollectionViewDelegateFlowLayout {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath) as! AppsGroupCollectionViewCell

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: view.frame.width, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
}

// MARK: - CollectionView Header

extension AppsViewController {

  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: headerIdentification,
                                                                 for: indexPath)

    return header
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {

    return .init(width: view.frame.width - 48, height: 300)
  }
}
