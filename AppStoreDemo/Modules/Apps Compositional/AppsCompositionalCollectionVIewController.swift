//
//  AppsCompositionalCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

enum AppSection {
  case socialApps
  case topNewApps
  case topGrossingApps
  case topFreeApps
  case topFreeAppsCopy
}

class AppsCompositionalCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let appsCompositionalHeaderReusableViewId = "AppsCompositionalHeaderReusableViewId"
  private let appsHeaderCollectionViewCellId = "AppsHeaderCollectionViewCellId"
  private let appsRowCollectionViewCellId = "AppsRowCollectionViewCellId"
  
  private var socialApps = [SocialApp]()
  private var newAppsGroup: AppGroup?
  private var topGrossingAppsGroup: AppGroup?
  private var topFreeAppsGroup: AppGroup?
  private var appsGroup: AppGroup?
  private var appId: String?
  private var headerTitle: String?
  
  private lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, AnyHashable> = .init(
  collectionView: self.collectionView) { (collectionView, indexPath, object) -> UICollectionViewCell? in
    
    if let socialApps = object as? SocialApp {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.appsHeaderCollectionViewCellId,
                                                    for: indexPath) as! AppsHeaderCollectionViewCell
      cell.socialApp = socialApps
      
      return cell
    } else if let groupApps = object as? FeedResult {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.appsRowCollectionViewCellId,
                                                    for: indexPath) as! AppsRowCollectionViewCell
      cell.app = groupApps
      cell.getButton.setTitle("Delete", for: .normal)
      cell.getButton.addTarget(self, action: #selector(self.handleDeleteCell), for: .primaryActionTriggered)
      
      return cell
    }
    
    return nil
  }
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()
  
  // MARK: - Initialization
  
  init() {
    
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
      if sectionNumber == 0 {
        return AppsCompositionalCollectionViewController.layoutSectionOne()
      } else {
        return AppsCompositionalCollectionViewController.layoutSectionTwo()
      }
    }
    
    super.init(collectionViewLayout: layout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupDiffableDataSource()
    setupActivityIndicator()
    setupNavigationButton()
    refreshController()
    //    fetchAppsData()
  }
  
  // MARK: - Helper Mehtods
  
  private func setupCollectionView() {
    navigationItem.title = "Apps"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.backgroundColor = .systemBackground
    
    // Register Collection Header View
    collectionView.register(AppsCompositionalHeaderReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: appsCompositionalHeaderReusableViewId)
    
    // Register Collection View Cell
    collectionView.register(AppsRowCollectionViewCell.self, forCellWithReuseIdentifier: appsRowCollectionViewCellId)
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: appsHeaderCollectionViewCellId)
  }
  
  private func setupNavigationButton() {
    navigationItem.rightBarButtonItem = .init(title: "Fecth New Section",
                                              style: .plain,
                                              target: self,
                                              action: #selector(handleFetchNewSection))
  }
  
  private func setupActivityIndicator() {
    view.addSubview(activityIndicatorView)
    activityIndicatorView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func refreshController() {
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshDeleteFreeAppsCopySection), for: .valueChanged)
  }
  
  // MARK: - Header DiffablDataSource
  
  private func setupHeaderDiffableDataSource() {
    diffableDataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: self.appsCompositionalHeaderReusableViewId,
                                                                   for: indexPath) as! AppsCompositionalHeaderReusableView
      
      let snapshot = self.diffableDataSource.snapshot()
      let object = self.diffableDataSource.itemIdentifier(for: indexPath)
      let section = snapshot.sectionIdentifier(containingItem: object!)
      
      switch section {
      case .topNewApps:
        self.headerTitle = self.newAppsGroup?.feed.title
      case .topGrossingApps:
        self.headerTitle = self.topGrossingAppsGroup?.feed.title
      case .topFreeApps:
        self.headerTitle = self.topFreeAppsGroup?.feed.title
        case .topFreeAppsCopy:
          self.headerTitle = self.topFreeAppsGroup?.feed.title
      default:
        print("No Titles to Display")
      }
      
      header.titleLabel.text = self.headerTitle
      return header
    })
  }
  
  // MARK: - Sections DiffablDataSource & Fetch Data
  
  private func setupDiffableDataSource() {    
    // Setup Header 
    setupHeaderDiffableDataSource()
    
    // Instantiate Diffable Snapshot
    var snapshot = self.diffableDataSource.snapshot()
    
    // Append Sections
    snapshot.appendSections([.socialApps, .topNewApps, .topGrossingApps, .topFreeApps])
    
    // Instantiate DispatchGroup
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    ServiceClient.shared.fetchSocialApps { (socialApps, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      // Append Social Apps
      snapshot.appendItems(socialApps ?? [], toSection: .socialApps)
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    ServiceClient.shared.fetchTopNewApps { [weak self] (topNewApps, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.newAppsGroup = topNewApps
      
      // Append New Apps
      guard let newApps = topNewApps?.feed.results else { return }
      snapshot.appendItems(newApps, toSection: .topNewApps)
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    ServiceClient.shared.fetchTopGrossingApps { [weak self] (topGrossingApps, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.topGrossingAppsGroup = topGrossingApps
      
      // Append Top Grossing Apps
      guard let topGrossingApps = topGrossingApps?.feed.results else { return }
      snapshot.appendItems(topGrossingApps, toSection: .topGrossingApps)
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    ServiceClient.shared.fetchTopFreeApps { [weak self] (topFreeApps, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.topFreeAppsGroup = topFreeApps
      
      // Append Top Free Apps
      guard let topFreeApps = topFreeApps?.feed.results else { return }
      snapshot.appendItems(topFreeApps, toSection: .topFreeApps)
      dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
      self.activityIndicatorView.stopAnimating()
      self.collectionView.reloadData()
      
      // Apply Snapshot
      self.diffableDataSource.apply(snapshot)
    }
  }
  
  // MARK: - Compositional Layout Mehtods
  
  static private func layoutSectionOne() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    item.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 16)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                     heightDimension: .absolute(320)),
                                                   subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 0)
    
    return section
  }
  
  static private func layoutSectionTwo() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1/3)))
    item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 16)
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                   heightDimension: .absolute(300)),
                                                 subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 0)
    
    let headerKind = UICollectionView.elementKindSectionHeader
    section.boundarySupplementaryItems = [ .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                   heightDimension: .absolute(60)),
                                                 elementKind: headerKind,
                                                 alignment: .topLeading)]
    
    return section
  }
  
  // MARK: - Actions
  
  @objc private func handleDeleteCell(button: UIButton) {
    var superview = button.superview
    
    // Reach for the parent cell button to access the indexPath
    while superview != nil {
      if let cell = superview as? UICollectionViewCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        guard let selectedIndexPath = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        // Delete selected cell
        var snapshot = diffableDataSource.snapshot()
        snapshot.deleteItems([selectedIndexPath])
        diffableDataSource.apply(snapshot)
      }
      superview = superview?.superview
    }
  }
  
  @objc private func handleFetchNewSection() {
    ServiceClient.shared.fetchTopFreeApps { [weak self] (topFreeApps, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      // Append Top Free Apps
      guard let strongSelf = self else { return }
      var snapshot = strongSelf.diffableDataSource.snapshot()
      snapshot.insertSections([.topFreeAppsCopy], afterSection: .socialApps)
      
      guard let topFreeApps = topFreeApps?.feed.results else { return }
      snapshot.appendItems(topFreeApps, toSection: .topFreeAppsCopy)
      
      strongSelf.diffableDataSource.apply(snapshot)
    }
  }
  
  @objc private func handleRefreshDeleteFreeAppsCopySection() {
    collectionView.refreshControl?.endRefreshing()
    
    var snapshot = diffableDataSource.snapshot()
    snapshot.deleteSections([.topFreeAppsCopy])
    diffableDataSource.apply(snapshot)
  }
}

// MARK: UICollectionViewDataSource

extension AppsCompositionalCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let itemIdentifier = diffableDataSource.itemIdentifier(for: indexPath)
    
    if let app = itemIdentifier as? SocialApp {
      self.appId = app.id
    } else if let app = itemIdentifier as? FeedResult {
      self.appId = app.id
    }
    
    let appsDetailController = AppsDetailCollectionViewController(appId: self.appId ?? "")
    navigationController?.pushViewController(appsDetailController, animated: true)
  }
}

// MARK: -

//  private func fetchAppsData() {
//    let dispatchGroup = DispatchGroup()
//
//    dispatchGroup.enter()
//    ServiceClient.shared.fetchSocialApps { [weak self] (socialApps, error) in
//      if let error = error {
//        print("Failed to Fetch Apps: ", error)
//        return
//      }
//
//      dispatchGroup.leave()
//      guard let strongSelf = self else { return }
//      strongSelf.socialApps = socialApps ?? []
//    }
//
//    dispatchGroup.enter()
//    ServiceClient.shared.fetcNewApps { [weak self] (newAppsGroup, error) in
//      if let error = error {
//        print("Failed to Fetch Apps: ", error)
//        return
//      }
//
//      dispatchGroup.leave()
//      guard let strongSelf = self else { return }
//      strongSelf.newAppsGroup = newAppsGroup
//    }
//
//    dispatchGroup.enter()
//    ServiceClient.shared.fetchTopGrossingApps { [weak self] (topGrossingAppGroup, error) in
//      if let error = error {
//        print("Failed to Fetch Apps: ", error)
//        return
//      }
//
//      dispatchGroup.leave()
//      guard let strongSelf = self else { return }
//      strongSelf.topGrossingAppsGroup = topGrossingAppGroup
//    }
//
//    dispatchGroup.enter()
//    ServiceClient.shared.fetchTopFreeApps { [weak self] (topFreeAppsGroup, error) in
//      if let error = error {
//        print("Failed to Fetch Apps: ", error)
//        return
//      }
//
//      dispatchGroup.leave()
//      guard let strongSelf = self else { return }
//      strongSelf.topFreeAppsGroup = topFreeAppsGroup
//    }
//
//    // Completion
//    dispatchGroup.notify(queue: .main) {
//      self.activityIndicatorView.stopAnimating()
//      self.collectionView.reloadData()
//    }
//  }
//}

// MARK: UICollectionViewDataSource

//extension AppsCompositionalCollectionViewController {
//
//  override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 0
//  }

//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    switch section {
//    case 0:
//      return socialApps.count
//    case 1:
//      return newAppsGroup?.feed.results.count ?? 0
//    case 2:
//      return topGrossingAppsGroup?.feed.results.count ?? 0
//    case 3:
//      return topFreeAppsGroup?.feed.results.count ?? 0
//    default:
//      print("No Apps to Display")
//    }
//
//    return 0
//  }

//  override func collectionView(_ collectionView: UICollectionView,
//                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    switch indexPath.section {
//    case 0:
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsHeaderCollectionViewCellId,
//                                                    for: indexPath) as! AppsHeaderCollectionViewCell
//
//      cell.socialApp = socialApps[indexPath.item]
//      return cell
//    default:
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsRowCollectionViewCellId,
//                                                    for: indexPath) as! AppsRowCollectionViewCell
//
//      switch indexPath.section {
//      case 1:
//        appsGroup = newAppsGroup
//      case 2:
//        appsGroup = topGrossingAppsGroup
//      case 3:
//        appsGroup = topFreeAppsGroup
//      default:
//        print("No Cells to Display")
//      }
//
//      cell.app = appsGroup?.feed.results[indexPath.item]
//      return cell
//    }
//  }

//  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    switch indexPath.section {
//    case 0:
//      appId = socialApps[indexPath.item].id
//    case 1:
//      appId = newAppsGroup?.feed.results[indexPath.item].id ?? ""
//    case 2:
//      appId = topGrossingAppsGroup?.feed.results[indexPath.item].id ?? ""
//    case 3:
//      appId = topFreeAppsGroup?.feed.results[indexPath.item].id ?? ""
//    default:
//      print("No Cells Selected")
//    }
//
//    guard let appId = appId else { return }
//    let appsDetailController = AppsDetailCollectionViewController(appId: appId)
//    navigationController?.pushViewController(appsDetailController, animated: true)
//  }
//}

// MARK: - CollectionViewHeader

//extension AppsCompositionalCollectionViewController {
//
//  override func collectionView(_ collectionView: UICollectionView,
//                               viewForSupplementaryElementOfKind kind: String,
//                               at indexPath: IndexPath) -> UICollectionReusableView {
//    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                 withReuseIdentifier: appsCompositionalHeaderReusableViewId,
//                                                                 for: indexPath) as! AppsCompositionalHeaderReusableView
//    switch indexPath.section {
//    case 1:
//      headerTitle = newAppsGroup?.feed.title
//    case 2:
//      headerTitle = topGrossingAppsGroup?.feed.title
//    case 3:
//      headerTitle = topFreeAppsGroup?.feed.title
//    default:
//      print("No Header Title to Display")
//    }
//
//    header.titleLabel.text = headerTitle
//    return header
//  }
//}
