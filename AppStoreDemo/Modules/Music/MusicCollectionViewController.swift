//
//  MusicCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MusicCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let musicCollectionViewCellId = "musicCollectionViewCellId"
  private let musicFooterCollectionReusableViewId = "musicFooterCollectionReusableViewId"
  
  // MARK: Initialization
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    collectionView.backgroundColor = .white
    
    // Register Collection View Cells
    collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: musicCollectionViewCellId)
    
    // Register Collection Footer View
    collectionView.register(MusicFooterCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: musicFooterCollectionReusableViewId)
  }
}

// MARK: - CollectionViewDataSource

extension MusicCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musicCollectionViewCellId,
                                                  for: indexPath) as! MusicCollectionViewCell    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: musicFooterCollectionReusableViewId,
                                                                 for: indexPath) as! MusicFooterCollectionReusableView
    
    return footer
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension MusicCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    
    return .init(width: view.frame.width, height: 100)
  }
}
