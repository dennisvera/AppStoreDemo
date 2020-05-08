//
//  AppsCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsCollectionViewController: UICollectionViewController {

  // MARK: - Properties

  private let AppsGroupCollectionViewCellId = "AppsGroupCollectionViewCellId"
  private let AppsHeaderReusableViewId = "AppsHeaderReusableViewId"
  private var appsFeedGroup: FeedGroup?
  private var socialApps = [SocialApp]()
  private var appGroups = [FeedGroup]()
  private var group1: FeedGroup?
  private var group2: FeedGroup?
  private var group3: FeedGroup?

  private let activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()

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
    setupActivityIndicator()
    fetchAppGroup()
  }


  // MARK: - Helper Mehtods

  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: AppsGroupCollectionViewCellId)
    collectionView.backgroundColor = .white

    // Register Collection Header View
    collectionView.register(AppsHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: AppsHeaderReusableViewId)
  }

  private func setupActivityIndicator() {
    view.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func fetchAppGroup() {
    let dispatchGroup = DispatchGroup()

    dispatchGroup.enter()
    ServiceClient.shared.fetcNewApps { (appGroup, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }

      dispatchGroup.leave()
      self.group1 = appGroup
    }

    dispatchGroup.enter()
    ServiceClient.shared.fetcTopGrossingApps { (appGroup, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }

      dispatchGroup.leave()
      self.group2 = appGroup
    }

    dispatchGroup.enter()
    ServiceClient.shared.fetcTopFreeApps { (appGroup, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }

      dispatchGroup.leave()
      self.group3 = appGroup
    }

    dispatchGroup.enter()
    ServiceClient.shared.fetchSocialApps { (apps, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }

      dispatchGroup.leave()
      self.socialApps = apps ?? []
    }

    dispatchGroup.notify(queue: .main) {
      self.activityIndicator.stopAnimating()

      if let group = self.group1 {
        self.appGroups.append(group)
      }

      if let group = self.group2 {
        self.appGroups.append(group)
      }

      if let group = self.group3 {
        self.appGroups.append(group)
      }

      self.collectionView.reloadData()
    }
  }
}

// MARK: UICollectionViewDataSource

extension AppsCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroups.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCollectionViewCellId,
                                                  for: indexPath) as! AppsGroupCollectionViewCell

    let appGroup = appGroups[indexPath.item]
    cell.titleLabel.text = appGroup.feed.title
    cell.horizontalViewController.appsFeedGroup = appGroup
    cell.horizontalViewController.collectionView.reloadData()

    // Navigate to the AppsDetailCollectionViewController via Handler
    cell.horizontalViewController.didSelectHandler = { [weak self] feedResult in
      guard let strongSelf = self else { return }
      let appsDetailController = AppsDetailCollectionViewController(appId: feedResult.id)
      appsDetailController.title = feedResult.name
      strongSelf.navigationController?.pushViewController(appsDetailController, animated: true)
    }
    
    return cell
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension AppsCollectionViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: view.frame.width, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
}

// MARK: - CollectionViewHeader

extension AppsCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: AppsHeaderReusableViewId,
                                                                 for: indexPath) as! AppsHeaderReusableView

    header.appsHeaderHorizontalViewController.socialApps = socialApps
    header.appsHeaderHorizontalViewController.collectionView.reloadData()
    return header
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    let leftAndRightPadding: CGFloat = 48
    
    return .init(width: view.frame.width - leftAndRightPadding, height: 300)
  }
}
