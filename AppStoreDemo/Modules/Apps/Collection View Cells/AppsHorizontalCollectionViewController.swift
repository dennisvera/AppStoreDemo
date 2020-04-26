//
//  AppsHorizontalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class AppsHorizontalCollectionViewController: UICollectionViewController {

  // MARK: - Properties

  private let reuseIdentifier = "reuseIdentifier"

  var appsFeedGroup: FeedGroup?

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

  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(AppsRowCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false

    // Sets the snapping behavior speed and content inset
    collectionView.decelerationRate = .fast
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}

// MARK: UICollectionViewDataSource

extension AppsHorizontalCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let count = appsFeedGroup?.feed.results.count else { return 0 }

    return count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! AppsRowCollectionViewCell

    let app = appsFeedGroup?.feed.results[indexPath.row]
    cell.nameLabel.text = app?.artistName
    cell.companyLabel.text = app?.name
    cell.appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))

    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {

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
}
