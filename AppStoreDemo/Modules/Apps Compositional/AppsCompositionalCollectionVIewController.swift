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
  
  private let appsCompositionalHeaderReusableViewId = "AppsCompositionalHeaderReusableViewId"
  private let appsHeaderCollectionViewCellId = "AppsHeaderCollectionViewCellId"
  private let appsRowCollectionViewCellId = "AppsRowCollectionViewCellId"
  
  // MARK: - Initialization
  
  init() {
    
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
      if sectionNumber == 0 {
        return AppsCompositionalCollectionViewController.layoutSectionOne()
      } else {
        return AppsCompositionalCollectionViewController.layoutSectionTwo()
      }
    }
    
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
  
  // MARK: - Helper Mehtods
  
  private func setupCollectionView() {
    navigationItem.title = "Apps"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.backgroundColor = .systemBackground
    
    // Register Collection Header View
    collectionView.register(AppsCompositionalHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: appsCompositionalHeaderReusableViewId)
    
    // Register Collection View Cell
    collectionView.register(AppsRowCollectionViewCell.self, forCellWithReuseIdentifier: appsRowCollectionViewCellId)
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: appsHeaderCollectionViewCellId)
  }
  
  static private func layoutSectionOne() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                     heightDimension: .absolute(300)),
                                                   subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 16
    
    return section
  }
  
  static private func layoutSectionTwo() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1/3)))
    item.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 16)
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                   heightDimension: .absolute(300)),
                                                 subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 16
    
    let headerKind = UICollectionView.elementKindSectionHeader
    section.boundarySupplementaryItems = [ .init(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                   heightDimension: .absolute(50)),
                                                 elementKind: headerKind,
                                                 alignment: .topLeading)]
    
    return section
  }
}

// MARK: UICollectionViewDataSource

extension AppsCompositionalCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsHeaderCollectionViewCellId,
                                                    for: indexPath) as! AppsHeaderCollectionViewCell
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsRowCollectionViewCellId,
                                                    for: indexPath) as! AppsRowCollectionViewCell
      cell.backgroundColor = .systemBlue
      return cell
    }
  }
}

// MARK: - CollectionViewHeader

extension AppsCompositionalCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: appsCompositionalHeaderReusableViewId,
                                                                 for: indexPath) as! AppsCompositionalHeaderReusableView
    return header
  }
}

