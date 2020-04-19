//
//  AppsHeaderHorizontalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalCollectionViewController: UICollectionViewController {

  // MARK: Properties

  private let reuseIdentifier = "reuseIdentifier"

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

    setupCollectionView()
  }

  // MARK: - Helper Methods

  private func setupCollectionView() {
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false

    // Set Collection View Scroll Direction to Horizontal
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
  }
}

// MARK: UICollectionViewDataSource

extension AppsHeaderHorizontalCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 3
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! AppsHeaderCollectionViewCell
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsHeaderHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return .init(width: view.frame.width - 48, height: view.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

    return .init(top: 0, left: 16, bottom: 0, right: 0)
  }
}
