//
//  AppsHeaderHorizontalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class AppsHeaderHorizontalCollectionViewController: UICollectionViewController {

  // MARK: Properties

  private let reuseIdentifier = "reuseIdentifier"
  var socialApps = [SocialApp]()

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

    return socialApps.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! AppsHeaderCollectionViewCell
    let app = socialApps[indexPath.item]
    cell.companyLabel.text = app.name
    cell.descriptionLabel.text = app.tagline
    cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
    
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

    return .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}
