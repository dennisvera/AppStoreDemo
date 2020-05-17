//
//  AppsCompositionalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsCompositionalCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let dummyCellId = "DummyCellId"
  
  // MARK: - Initialization

  init() {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    item.contentInsets.bottom = 16
    item.contentInsets.trailing = 16
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                     heightDimension: .absolute(300)),
                                                   subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 32
    
    let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
    
    super.init(collectionViewLayout: compositionalLayout)
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
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dummyCellId,
                                                  for: indexPath)
    cell.backgroundColor = .systemRed
    
    return cell
  }
}
