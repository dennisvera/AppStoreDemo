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
    
    collectionView.backgroundColor = .gray
  }
  
  // MARK: - Helper Methods
}

// MARK: UICollectionViewDataSource

extension TodayCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    
    return cell
  }
}
