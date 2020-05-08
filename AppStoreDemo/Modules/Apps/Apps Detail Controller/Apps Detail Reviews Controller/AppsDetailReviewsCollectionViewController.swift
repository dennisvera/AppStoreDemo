//
//  AppsDetailReviewsCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/7/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsDetailReviewsCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let appsDetailReviewsAndRatingsCollectionViewCellId = "AppsDetailReviewsAndRatingsCollectionViewCellId"
  var appReviews: Reviews? {
    didSet {
      collectionView.reloadData()
    }
  }
  
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
    // Register Collection View Cell
    collectionView.register(AppsDetailReviewsAndRatingsCollectionViewCell.self,
                            forCellWithReuseIdentifier: appsDetailReviewsAndRatingsCollectionViewCellId)
    collectionView.backgroundColor = .white
    
    // Sets the snapping behavior speed and content inset
    collectionView.decelerationRate = .fast
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}

// MARK: UICollectionViewDataSource

extension AppsDetailReviewsCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let count = appReviews?.feed.entry.count else { return 0 }
    
    return count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetailReviewsAndRatingsCollectionViewCellId,
                                                  for: indexPath) as! AppsDetailReviewsAndRatingsCollectionViewCell
    let appReview = appReviews?.feed.entry[indexPath.item]
    cell.titleLabel.text = appReview?.title.label
    cell.authorLabel.text = appReview?.author.name.label
    cell.reviewLabel.text = appReview?.content.label
    cell.ratingLabel.text = appReview?.rating.label
    
    // Converts the enpoint rating string into an Int to properly display
    // the correct number of stars.
    for (index, view) in
      cell.ratingStackView.arrangedSubviews.enumerated() {
        if let ratingInt = Int(appReview?.rating.label ?? "") {
          view.alpha = index >= ratingInt ? 0 : 1
        }
    }
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsDetailReviewsCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
