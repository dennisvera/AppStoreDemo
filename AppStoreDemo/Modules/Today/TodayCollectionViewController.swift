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
  
  private let todayCollectionViewCellId = "todayCollectionViewCellId"
  
  var appFullScreenController: AppFullScreenTableViewController!
  var startingFrame: CGRect?
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  
  let items = [
    TodayItem(category: "LIFE HACK",
              title: "Utilizing your Time",
              image: #imageLiteral(resourceName: "gardenImage"),
              description: "All the tools and apps you need to intelligently orginize your life the right way.",
              backgroundColor: .white),
    TodayItem(category: "HOLIDAYS",
              title: "Travel on a Budget",
              image: #imageLiteral(resourceName: "holiday_Image"),
              description: "Find out all you need to know on how to travel without packing everything!",
              backgroundColor: #colorLiteral(red: 0.988055408, green: 0.958909452, blue: 0.7275250554, alpha: 1))
  ]
  
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
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = #colorLiteral(red: 0.9489468932, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
    
    // Register Collection View Cell
    collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: todayCollectionViewCellId)
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
                    self.tabBarController?.tabBar.transform = .identity
                    //                    self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - 80
                    
    }, completion: { [weak self] _ in
      guard let strongSelf = self else { return }
      strongSelf.appFullScreenController.view.removeFromSuperview()
      strongSelf.appFullScreenController.removeFromParent()
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCollectionViewCellId,
                                                  for: indexPath) as! TodayCollectionViewCell
    cell.todayItem = items[indexPath.item]
    
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
                    
    }, completion: nil)
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TodayCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let leftAndRightPadding: CGFloat = 64
    
    return .init(width: view.frame.width - leftAndRightPadding, height: 450)
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
