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

  private let AppsHeaderCollectionViewCellId = "AppsHeaderCollectionViewCellId"
  var socialApps = [SocialApp]()

  // MARK: - Initialization

  init() {
    let layout = SnappingCollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
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
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: AppsHeaderCollectionViewCellId)
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false

    // Sets the snapping behavior speed and content inset
    collectionView.decelerationRate = .fast
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}

// MARK: UICollectionViewDataSource

extension AppsHeaderHorizontalCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return socialApps.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCollectionViewCellId,
                                                  for: indexPath) as! AppsHeaderCollectionViewCell
    let app = socialApps[indexPath.item]
    cell.socialApp = app
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsHeaderHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let leftAndRightPadding: CGFloat = 48

    return .init(width: view.frame.width - leftAndRightPadding, height: view.frame.height)
  }
}
