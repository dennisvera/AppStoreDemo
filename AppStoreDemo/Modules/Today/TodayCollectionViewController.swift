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
  
  private var singleAppFullScreenController: AppFullScreenTableViewController!
  private var items = [TodayItem]()
  private var topGrossingAppsGroup: AppGroup?
  private var newAppsGroup: AppGroup?
  
  static let cellHeight: CGFloat = 500
  private var startingFrame: CGRect?
  private var topConstraint: NSLayoutConstraint?
  private var leadingConstraint: NSLayoutConstraint?
  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  
  private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
  private var singleAppFullScreenBeginOffset: CGFloat = 0
  
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
    fetchApps()
    setupActivityIndicatorView()
    setupBlurVisualEffectView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // TODO - SOLUTION IS NOT WORKING
    // SOLUTIION: This fixes the bug of the tab bar not anchoring down when seguing back to the controller
    tabBarController?.tabBar.superview?.setNeedsLayout()
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
  
  private func setupBlurVisualEffectView() {
    view.addSubview(blurVisualEffectView)
    blurVisualEffectView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    blurVisualEffectView.alpha = 0
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
        print("Failed to Fetch Apps: ", error)
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
  
  private func showGroupAppDailyListFullScreen(_ indexPath: IndexPath) {
    let todayMultipleAppsController = TodayMultipleAppsCollectionViewController(screenType: .fullAppListScreen)
    let navigationController = BackEnabledNavigationController(rootViewController: todayMultipleAppsController)
    todayMultipleAppsController.apps = self.items[indexPath.item].apps
    present(navigationController, animated: true)
  }
  
  private func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
    let appFullScreenTableViewController = AppFullScreenTableViewController()
    appFullScreenTableViewController.todayItem = items[indexPath.row]
    
    appFullScreenTableViewController.dismissHandler = {
      self.dismissSingleAppFullScreenController()
    }
    
    appFullScreenTableViewController.view.layer.cornerRadius = 16
    self.singleAppFullScreenController = appFullScreenTableViewController
    
    // setup pan gesture
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSingleAppScreenDrag))
    gestureRecognizer.delegate = self
    appFullScreenTableViewController.view.addGestureRecognizer(gestureRecognizer)
    
    // add a blue effect view
    
    // Check that we are not interfering wiht the tableview scrollling
  }
  
  private func setupSingleAppStartingCellFrame(_ indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    // Absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
  }
  
  private func setSingleAppFullScreenStartingPosition(_ indexPath: IndexPath) {
    let singleAppFullScreen = singleAppFullScreenController.view!
    view.addSubview(singleAppFullScreen)
    
    addChild(singleAppFullScreenController)
    
    // Disable the collectionView interaction to fix bug
    collectionView.isUserInteractionEnabled = false
    
    setupSingleAppStartingCellFrame(indexPath)
    
    // Auto Layout Animation constraints
    guard let startingFrame = startingFrame else { return }
    singleAppFullScreen.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = singleAppFullScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = singleAppFullScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = singleAppFullScreen.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = singleAppFullScreen.heightAnchor.constraint(equalToConstant: startingFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    
    self.view.layoutIfNeeded()
  }
  
  private func startSingleAppFullScreenAnimation(_ indexPath: IndexPath) {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    
                    self.blurVisualEffectView.alpha = 1
                    
                    self.topConstraint?.constant = 0
                    self.leadingConstraint?.constant = 0
                    self.widthConstraint?.constant = self.view.frame.width
                    self.heightConstraint?.constant = self.view.frame.height
                    
                    // Starts Animation
                    self.view.layoutIfNeeded()
                    
                    self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                    
                    // Set the TodayCollectionViewCell topConstraint below the status bar to 48pts
                    guard let cell = self.singleAppFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderTableViewCell else { return }
                    cell.todayCell.topConstraint.constant = 48
                    cell.layoutIfNeeded()
                    
    }, completion: nil)
  }
  
  private func showSingleAppFullScreen(_ indexPath: IndexPath) {
    // Instantiate SingleAppFullScreenController
    setupSingleAppFullScreenController(indexPath)
    
    // Setup single App fullScreen in it's starting position
    setSingleAppFullScreenStartingPosition(indexPath)

    // Start single app full screen animation
    startSingleAppFullScreenAnimation(indexPath)
  }
  
  // MARK: Actions
  
  @objc private func dismissSingleAppFullScreenController() {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    
                    self.singleAppFullScreenController.tableView.contentOffset = .zero
                    
                    self.blurVisualEffectView.alpha = 0
                    self.singleAppFullScreenController.view.transform = .identity
                    
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
                    guard let cell = self.singleAppFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderTableViewCell else { return }
                    cell.dismissButton.alpha = 0
                    cell.todayCell.topConstraint.constant = 24
                    cell.layoutIfNeeded()
                    
    }, completion: { [weak self] _ in
      guard let strongSelf = self else { return }
      strongSelf.singleAppFullScreenController.view.removeFromSuperview()
      strongSelf.singleAppFullScreenController.removeFromParent()
      strongSelf.collectionView.isUserInteractionEnabled = true
    })
  }
  
  @objc private func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
    let selectedView = gesture.view
    
    var superView = selectedView?.superview
    
    // Find the tapped cell
    while superView != nil {
      if let cell = superView as? TodayMultipleAppsCollectionViewCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        let apps = self.items[indexPath.item].apps
        
        let fullAppListController = TodayMultipleAppsCollectionViewController(screenType: .fullAppListScreen)
        fullAppListController.apps = apps
        present(BackEnabledNavigationController(rootViewController: fullAppListController), animated: true)
        return
      }
      
      superView = superView?.superview
    }
  }
  
  @objc private func handleSingleAppScreenDrag(gesture: UIPanGestureRecognizer) {
    if gesture.state == .began {
      singleAppFullScreenBeginOffset = singleAppFullScreenController.tableView.contentOffset.y
    }
    
    // Exit out if the tableview is not below 0 (top of the view)
    if singleAppFullScreenController.tableView.contentOffset.y > 0 {
      return
    }
    
    let translationY = gesture.translation(in: singleAppFullScreenController.view).y
    
    if gesture.state == .changed {
      if translationY > 0 {
        let trueOffset = translationY - singleAppFullScreenBeginOffset
        var scale = 1 - trueOffset / 1000
        
        // Stop scaling if the screen grows above 1. When scrolling up.
        scale = min(1, scale)
        // Stop scaling if the screen shrinks below 0.5. When scrolling down.
        scale = max(0.5, scale)
        
        let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
        singleAppFullScreenController.view.transform = transform
      }
    } else if gesture.state == .ended {
      if translationY > 0 {
        dismissSingleAppFullScreenController()
      }
    }
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
    
    // Enable tapping of Multiple Cells
    (cell as? TodayMultipleAppsCollectionViewCell)?.todayMultipleAppsController.collectionView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch items[indexPath.item].cellType {
    case .multiple:
      showGroupAppDailyListFullScreen(indexPath)
    case .single:
      showSingleAppFullScreen(indexPath)
    }
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

extension TodayCollectionViewController: UIGestureRecognizerDelegate {
  
  // Necessary to allow the view scrolling after the gestureRecognizer delgate is set to self
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
  }
}
