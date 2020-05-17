//
//  AppsCompositionalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsCompositionalCollectionViewController: UICollectionViewController {
  
  private let dummyCellId = "DummyCellId"

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

  // MARK: - Helper Mehtods

  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: dummyCellId)
    
    title = "Apps"
    collectionView.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}

// MARK: UICollectionViewDataSource

extension AppsCompositionalCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dummyCellId,
                                                  for: indexPath)
    cell.backgroundColor = .systemRed
    
    return cell
  }
}

//// MARK: - CollectionViewDelegateFlowLayout
//
//extension AppsCompositionalCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    return CGSize(width: 200, height: 200)
//  }
//
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    return .init(top: 16, left: 0, bottom: 16, right: 0)
//  }
//}
