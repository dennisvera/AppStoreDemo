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

  private let appsDetaiCellId = "appsDetaiCellId"
  private let appsDetailPreviewCellId = "appsDetailPreviewCellId"
  private let appsDetailReviewsCellId = "appsDetailReviewsCellId"
  private var app: Result?
  private var appReviews: Reviews?
  private var cellHeight: CGFloat = 300
  
  fileprivate var appId: String
  
  // MARK: - Initialization
  
  init(appId: String) {
    self.appId = appId
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    
    // This is Dependency Injection / Constructor.
    // We are injecting the appId everytime the controller is instantiated.
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    fetchData()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(AppsDetailCollectionViewCell.self, forCellWithReuseIdentifier: appsDetaiCellId)
    collectionView.register(AppsDetailPreviewCollectionViewCell.self, forCellWithReuseIdentifier: appsDetailPreviewCellId)
    collectionView.register(AppsDetailReviewsCollectionViewCell.self, forCellWithReuseIdentifier: appsDetailReviewsCellId)
    collectionView.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
  }
  
  private func fetchData() {
    ServiceClient.shared.fetchAppWith(id: appId) { [weak self] result, error in
      guard let strongSelf = self else { return }
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      let app = result?.results.first
      strongSelf.app = app
      
      DispatchQueue.main.async {
        strongSelf.collectionView.reloadData()
      }
    }
    
    ServiceClient.shared.fetchAppReview(id: appId) { [weak self] reviews, error in
      guard let strongSelf = self else { return }
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }

      strongSelf.appReviews = reviews

      DispatchQueue.main.async {
        strongSelf.collectionView.reloadData()
      }
    }
  }
}

// MARK: UICollectionViewDataSource

extension AppsDetailCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetaiCellId, for: indexPath) as! AppsDetailCollectionViewCell
      cell.app = app
          
      return cell
    } else if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetailPreviewCellId,
                                                    for: indexPath) as! AppsDetailPreviewCollectionViewCell
      cell.appsDetailPreviewCollectionViewController.app = self.app
      
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsDetailReviewsCellId,
                                                    for: indexPath) as! AppsDetailReviewsCollectionViewCell
      cell.appsDetailReviewCollectionViewController.appReviews = self.appReviews
      
      return cell
    }
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.item == 0 {
      // Calculates the necessary cell size
      let arbitraryHeight: CGFloat = 1000
      let resizingCell = AppsDetailCollectionViewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: arbitraryHeight))
      resizingCell.app = app
      resizingCell.layoutIfNeeded()
      
      let estimatedCellSize = resizingCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: arbitraryHeight))
      
      cellHeight = estimatedCellSize.height
    } else if indexPath.item == 1 {
      cellHeight = 500
    } else {
      cellHeight = 300
    }
    
    return .init(width: view.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 16, right: 0)
  }
}
