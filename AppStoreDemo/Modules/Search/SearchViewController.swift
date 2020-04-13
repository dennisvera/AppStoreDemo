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
    let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }

      guard let data = data else { return }

      do {
        let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
        searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)
      }
    }.resume()
  }

  // MARK: - CollectionView Delegate

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCollectionViewCell
    return cell
  }
}
