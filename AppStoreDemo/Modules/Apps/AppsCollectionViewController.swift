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

  private let reuseIdentifier = "reuseIdentifier"
  private let headerIdentification = "HeaderId"
  private var musicResults = [FeedResult]()

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
    fetchItunesMusic()
  }


  // MARK: - Helper Mehtods

  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white

    // Register Collection Header View
    collectionView.register(AppsHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: headerIdentification)
  }

  private func fetchItunesMusic() {
    ItunesClient.shared.fetchMusic { (results, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }

      if let results = results {
        self.musicResults = results.feed.results
        print(self.musicResults)
      }

      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
}

// MARK: UICollectionViewDataSource

extension AppsCollectionViewController {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return 5
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! AppsGroupCollectionViewCell

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
                                                                 withReuseIdentifier: headerIdentification,
                                                                 for: indexPath)

    return header
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {

    return .init(width: view.frame.width - 48, height: 300)
  }
}
