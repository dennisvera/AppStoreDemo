//
//  SearchViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  // MARK: - Properties

  fileprivate var searchResults = [Result]()
  fileprivate var timer: Timer?

  fileprivate let cellId = "AppsSearchId"
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  fileprivate let enterSearchaTermLabel: UILabel = {
    let label = UILabel()
    label.text = "Please enter search term above..."
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
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

    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    fetchItunesApps()
    setupSearchBar()
    setupEnterSearchTextLabel()
  }

  // MARK: - Helper Methods

  fileprivate func fetchItunesApps() {
    ItunesClient.shared.fetchApps(searchTerm: "Facebook") { results, error in
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

  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // Set a delay before performing a search -- Timer throttling after 0.5 sec
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
      ItunesClient.shared.fetchApps(searchTerm: searchText) { results, error in
        self.searchResults = results

        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
  }

  fileprivate func setupEnterSearchTextLabel() {
    collectionView.addSubview(enterSearchaTermLabel)
    enterSearchaTermLabel.snp.makeConstraints { make in
      make.top.equalTo(140)
      make.leading.equalTo(50)
      make.trailing.equalTo(-50)
    }
  }

  // MARK: - CollectionView Delegate

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Set the search term label if count is 0
    enterSearchaTermLabel.isHidden = searchResults.count != 0

    return searchResults.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCollectionViewCell
    cell.searchResult = searchResults[indexPath.item]

    return cell
  }
}
