//
//  SearchViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  // MARK: - Properties

  fileprivate let cellId = "AppsSearchId"
  fileprivate var searchResults = [Result]()

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

    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    fetchItunesApps()
  }

  // MARK: - Helper Methods

  fileprivate func fetchItunesApps() {
    ItunesClient.shared.fetchApps { results, error in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }

      self.searchResults = results

      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  // MARK: - CollectionView Delegate

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchResults.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCollectionViewCell

    let searchResult = searchResults[indexPath.item]
    cell.nameLabel.text = searchResult.trackName
    cell.categoryLabel.text = searchResult.primaryGenreName
    cell.ratingsLabel.text = "\(searchResult.averageUserRating ?? 0)"

    return cell
  }
}
