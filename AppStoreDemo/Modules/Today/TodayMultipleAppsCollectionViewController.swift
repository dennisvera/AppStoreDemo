//
//  TodayMultipleAppsCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodayMultipleAppsCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let multipleAppsCollectionViewCellId = "MultipleAppsCollectionViewCellId"
  private let lineSpacing: CGFloat = 16
  
  var appResults = [FeedResult]()
  
  // MARK: - Intialization
  
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
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = false
    
    // Register Collection View Cells
    collectionView.register(TopGrossingAppsCollectionViewCell.self, forCellWithReuseIdentifier: multipleAppsCollectionViewCellId)
  }
}

// MARK: UICollectionViewDataSource

extension TodayMultipleAppsCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return min(4, appResults.count)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppsCollectionViewCellId,
                                                  for: indexPath) as! TopGrossingAppsCollectionViewCell
    cell.app = appResults[indexPath.item]
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TodayMultipleAppsCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let betweenCellSpacing: CGFloat = 3
    let numberOfRows: CGFloat = 4
    let height = (view.frame.height - betweenCellSpacing * lineSpacing) / numberOfRows
    
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
   
    return lineSpacing
  }

}
