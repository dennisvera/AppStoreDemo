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
  var appId: String? {
    didSet {
      guard let appId = appId else { return }
      ServiceClient.shared.fetchApps(id: appId) { result, error in
        let app = result?.results.first
        self.app = app
        
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
  
  var app: Result?
  
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
    cell.app = app
        
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // Calculates the necessary cell size
    let resizingCell = AppsDetailCollectionViewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    resizingCell.app = app
    resizingCell.layoutIfNeeded()
    
    let estimatedCellSize = resizingCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    
    return .init(width: view.frame.width, height: estimatedCellSize.height)
  }
}
