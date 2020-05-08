//
//  TodayCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/8/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let todayCollectionViewCellId = "todayCollectionViewCellId"
  
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
    // Register Collection View Cell
    collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: todayCollectionViewCellId)
    collectionView.backgroundColor = #colorLiteral(red: 0.9489468932, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
    
    navigationController?.isNavigationBarHidden = true
  }
}

// MARK: UICollectionViewDataSource

extension TodayCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCollectionViewCellId, for: indexPath) as! TodayCollectionViewCell
    cell.backgroundColor = .white
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // TO DO
    print("Animate cell when tapped")
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TodayCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let leftAndRightPadding: CGFloat = 64
    
    return .init(width: view.frame.width - leftAndRightPadding, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let lineSpacing: CGFloat = 32
    
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
}
