//
//  TodayMultipleAppsCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

enum ScreenType {
  
  case shortAppListScreen
  case fullAppListScreen
}

class TodayMultipleAppsCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  override var prefersStatusBarHidden: Bool { return true }

  private let appGroupsCollectionViewCellId = "appGroupsCollectionViewCellId"
  private let screenType: ScreenType
  private let lineSpacing: CGFloat = 16
  
  var appResults = [FeedResult]()
  
  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    button.tintColor = .darkGray
    button.addTarget(self, action: #selector(handleDissmissButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Intialization
  
  init(screenType: ScreenType) {
    self.screenType = screenType
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
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = false
        
    // Register Collection View Cells
    collectionView.register(AppGroupsCollectionViewCell.self, forCellWithReuseIdentifier: appGroupsCollectionViewCellId)
    
    if screenType == .fullAppListScreen {
      setupDismissButton()
      navigationController?.isNavigationBarHidden = true
    } else {
      collectionView.isScrollEnabled = true
    }
  }
  
  private func setupDismissButton() {
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { make in
      make.top.equalTo(view.snp.topMargin).offset(20)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
      make.width.height.equalTo(44)
    }
  }
  
  // MARK: Actions
  
  @objc private func handleDissmissButton() {
    dismiss(animated: true)
  }
}

// MARK: UICollectionViewDataSource

extension TodayMultipleAppsCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if screenType == .fullAppListScreen {
      return appResults.count
    }
    
    return min(4, appResults.count)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appGroupsCollectionViewCellId,
                                                  for: indexPath) as! AppGroupsCollectionViewCell
    cell.app = appResults[indexPath.item]
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = appResults[indexPath.item].id
    let appDetailController = AppsDetailCollectionViewController(appId: appId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TodayMultipleAppsCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height: CGFloat = 74
    
    if screenType == .fullAppListScreen {
      let leadingAndTrailingPadding: CGFloat = 48
      return .init(width: view.frame.width - leadingAndTrailingPadding, height: height)
    }
    
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    if screenType == .fullAppListScreen {
      return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
   
    return lineSpacing
  }

}
