//
//  AppsDetailPreviewCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/7/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsDetailPreviewCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties"
  
  private let appsDetailPreviewScreensCollectionViewCellId = "AppsDetailPreviewScreensCollectionViewCellId"
  var app: Result? {
    didSet {
      collectionView.reloadData()
    }
  }
  
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
    collectionView.register(AppsDetailPreviewScreensCollectionViewCell.self,
                            forCellWithReuseIdentifier: appsDetailPreviewScreensCollectionViewCellId)
    collectionView.backgroundColor = .white
    
    // Sets the snapping behavior speed and content inset
    collectionView.decelerationRate = .fast
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
}

// MARK: UICollectionViewDataSource

extension AppsDetailPreviewCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return app?.screenshotUrls.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetailPreviewScreensCollectionViewCellId,
                                                  for: indexPath) as! AppsDetailPreviewScreensCollectionViewCell
    let screenShotUrl = self.app?.screenshotUrls[indexPath.item]
    cell.screensImageView.sd_setImage(with: URL(string: screenShotUrl ?? ""))
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsDetailPreviewCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: 250, height: view.frame.height)
  }
}
