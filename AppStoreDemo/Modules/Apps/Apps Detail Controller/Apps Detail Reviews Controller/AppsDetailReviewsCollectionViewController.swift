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
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetailReviewsAndRatingsCollectionViewCellId,
                                                  for: indexPath) as! AppsDetailReviewsAndRatingsCollectionViewCell
    
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
