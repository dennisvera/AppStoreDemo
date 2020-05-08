//
//  SearchCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class SearchCollectionViewController: UICollectionViewController, UISearchBarDelegate {

  // MARK: - Properties

  private var searchResults = [Result]()
  private var timer: Timer?

  private let reuseIdentifier = "reuseIdentifier"
  private let instagram = "instagram"
  private let searchController = UISearchController(searchResultsController: nil)
  private let enterSearchaTermLabel: UILabel = {
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

    setupCollectionView()
    fetchItunesApps()
    setupSearchBar()
    setupEnterSearchTextLabel()
  }

  // MARK: - Helper Methods

  private func setupCollectionView() {
    // Register Collection View Cell
    collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
  }

  private func fetchItunesApps() {
    ServiceClient.shared.fetchApps(searchTerm: instagram) { [weak self] search, error in
      guard let strongSelf = self else {return }

      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }

      strongSelf.searchResults = search?.results ?? []

      DispatchQueue.main.async {
        strongSelf.collectionView.reloadData()
      }
    }
  }

  private func setupSearchBar() {
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
      ServiceClient.shared.fetchApps(searchTerm: searchText) { [weak self] search, error in
        guard let strongSelf = self else {return }
        if let error = error {
          print("Failed to Fetch Apps: ", error)
          return
        }

        strongSelf.searchResults = search?.results ?? []

        DispatchQueue.main.async {
          strongSelf.collectionView.reloadData()
        }
      }
    })
  }

  private func setupEnterSearchTextLabel() {
    collectionView.addSubview(enterSearchaTermLabel)
    enterSearchaTermLabel.snp.makeConstraints { make in
      make.top.equalTo(140)
      make.leading.equalTo(50)
      make.trailing.equalTo(-50)
    }
  }
}

// MARK: UICollectionViewDataSource

extension SearchCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = String(searchResults[indexPath.item].trackId)
    let appDetailController = AppsDetailCollectionViewController(appId: appId)
    
    navigationController?.pushViewController(appDetailController, animated: true)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Set the search term label if count is 0
    enterSearchaTermLabel.isHidden = searchResults.count != 0

    return searchResults.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: view.frame.width, height: 350)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! SearchResultCollectionViewCell
    cell.searchResult = searchResults[indexPath.item]

    return cell
  }
}
