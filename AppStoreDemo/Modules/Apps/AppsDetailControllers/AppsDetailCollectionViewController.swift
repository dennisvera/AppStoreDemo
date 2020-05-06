//
//  AppsDetailCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/26/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsDetailCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties

  private let appsDetaiCellId = "reuseIdentifier"
  var appId: String! {
    didSet {
      ServiceClient.shared.fetchApps(id: appId) { result, error in
        print(result?.results.first?.releaseNotes ?? "")
      }
    }
  }

  // MARK: - Initilalization

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
    collectionView.register(AppsDetailCollectionViewCell.self, forCellWithReuseIdentifier: appsDetaiCellId)
    collectionView.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
  }
}

// MARK: UICollectionViewDataSource

extension AppsDetailCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetaiCellId, for: indexPath) as! AppsDetailCollectionViewCell
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: view.frame.width, height: 300)
  }
}
