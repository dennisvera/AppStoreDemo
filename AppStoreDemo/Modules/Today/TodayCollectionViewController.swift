//
//  TodayCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/8/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodayCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private var appFullScreenController: AppFullScreenTableViewController!
  private var items = [TodayItem]()
  private var topGrossingAppsGroup: AppGroup?
  private var newAppsGroup: AppGroup?
  
  static let cellHeight: CGFloat = 500
  private var startingFrame: CGRect?
  private var topConstraint: NSLayoutConstraint?
  private var leadingConstraint: NSLayoutConstraint?
  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()
  
  // MARK: - Intialization
  
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
    setupActivityIndicatorView()
    fetchApps()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = #colorLiteral(red: 0.9489468932, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
    
    // Register Collection View Cells
    collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppsCollectionViewCell.self,
                            forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
  }
  
  private func setupActivityIndicatorView() {
    view.addSubview(activityIndicatorView)
    activityIndicatorView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func fetchApps() {
    // Instantiate DispatchGroup
    let disptachGroup = DispatchGroup()
    
    // Start First DispatchGroup
    disptachGroup.enter()
    ServiceClient.shared.fetchTopGrossingApps { [weak self] (appsGroup, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.topGrossingAppsGroup = appsGroup
      
      // Leave First DispatchGroup
      disptachGroup.leave()
    }
    
    // Starts Second DispatchGroup
    disptachGroup.enter()
    ServiceClient.shared.fetcNewApps { [weak self] (appsGroup, error)  in
      if let error = error {
        print("Failed to Fetch Apss: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.newAppsGroup = appsGroup
      
      // Leave Second DispatchGroup
      disptachGroup.leave()
    }
    
    // DispatchGroup Notification
    disptachGroup.notify(queue: .main) {
      self.activityIndicatorView.stopAnimating()
      
      self.items = [
        TodayItem(category: "DAILY LIST",
                  title: self.topGrossingAppsGroup?.feed.title ?? "",
                  image: #imageLiteral(resourceName: "gardenImage"),
                  description: "",
                  backgroundColor: .white, cellType: .multiple,
                  apps: self.topGrossingAppsGroup?.feed.results ?? []),
        TodayItem(category: "LIFE HACK",
                  title: "Utilizing your Time",
                  image: #imageLiteral(resourceName: "gardenImage"),
                  description: "All the tools and apps you need to intelligently orginize your life the right way.",
                  backgroundColor: .white, cellType: .single,
                  apps: []),
        TodayItem(category: "DAILY LIST",
                  title: self.newAppsGroup?.feed.title ?? "",
                  image: #imageLiteral(resourceName: "gardenImage"),
                  description: "",
                  backgroundColor: .white, cellType: .multiple,
                  apps: self.newAppsGroup?.feed.results ?? []),
        TodayItem(category: "HOLIDAYS",
                  title: "Travel on a Budget",
                  image: #imageLiteral(resourceName: "holiday_Image"),
                  description: "Find out all you need to know on how to travel without packing everything!",
                  backgroundColor: #colorLiteral(red: 0.988055408, green: 0.958909452, blue: 0.7275250554, alpha: 1), cellType: .single,
                  apps: [])
      ]
      
      self.collectionView.reloadData()
    }
  }
  
  // MARK: Actions
  
  @objc private func dismissFullScreenController() {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    
                    self.appFullScreenController.tableView.contentOffset = .zero
                    
                    guard let startingFrame = self.startingFrame else { return }
                    self.topConstraint?.constant = startingFrame.origin.y
                    self.leadingConstraint?.constant = startingFrame.origin.x
                    self.widthConstraint?.constant = startingFrame.width
                    self.heightConstraint?.constant = startingFrame.height
                    
                    // Stops the animation
                    self.view.layoutIfNeeded()
                    
                    // Unhide TabBar
                    self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - 80
                    
                    // Set the TodayCollectionViewCell topConstraint below the status bar to 24pts
                    guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderTableViewCell else { return }
                    cell.todayCell.topConstraint.constant = 24
                    cell.layoutIfNeeded()
                    
    }, completion: { [weak self] _ in
      guard let strongSelf = self else { return }
      strongSelf.appFullScreenController.view.removeFromSuperview()
      strongSelf.appFullScreenController.removeFromParent()
      strongSelf.collectionView.isUserInteractionEnabled = true
    })
  }
}

// MARK: UICollectionViewDataSource

extension TodayCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellIdentifier = items[indexPath.item].cellType.rawValue
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    
    if let cell = cell as? TodayCollectionViewCell {
      cell.todayItem = items[indexPath.item]
    } else if let cell = cell as? TodayMultipleAppsCollectionViewCell {
      cell.todayItem = items[indexPath.item]
    }
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appFullScreenController = AppFullScreenTableViewController()
    appFullScreenController.todayItem = items[indexPath.row]
    
    appFullScreenController.dismissHandler = {
      self.dismissFullScreenController()
    }
    
    let appFullScreenView = appFullScreenController.view!
    appFullScreenView.layer.cornerRadius = 16
    view.addSubview(appFullScreenView)
    
    addChild(appFullScreenController)
    
    self.appFullScreenController = appFullScreenController
    
    // Disable the collectionView interaction to fix bug
    collectionView.isUserInteractionEnabled = false
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
    
    // Auto Layout Animation constraints
    appFullScreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    
    self.view.layoutIfNeeded()

    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    
                    self.topConstraint?.constant = 0
                    self.leadingConstraint?.constant = 0
                    self.widthConstraint?.constant = self.view.frame.width
                    self.heightConstraint?.constant = self.view.frame.height
                    
                    // Starts Animation
                    self.view.layoutIfNeeded()
                    
                    self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                    
                    // Set the TodayCollectionViewCell topConstraint below the status bar to 48pts
                    guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderTableViewCell else { return }
                    cell.todayCell.topConstraint.constant = 48
                    cell.layoutIfNeeded()
                    
    }, completion: nil)
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TodayCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let leftAndRightPadding: CGFloat = 64
    
    return .init(width: view.frame.width - leftAndRightPadding, height: TodayCollectionViewController.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let lineSpacing: CGFloat = 32
    
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    let minusNavigationBarAndPadding: CGFloat = -80
    
    return .init(top: minusNavigationBarAndPadding, left: 0, bottom: 32, right: 0)
  }
}
