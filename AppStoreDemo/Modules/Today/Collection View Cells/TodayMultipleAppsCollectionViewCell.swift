//
//  TodayMultipleAppsCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodayMultipleAppsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = .lightGray
    return label
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 28)
    return label
  }()
  
  let todayMultipleAppsController = TodayMultipleAppsCollectionViewController()
  
  var todayItem: TodayItem? {
    didSet {
      guard let todayItem = todayItem else { return }
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      backgroundColor = todayItem.backgroundColor
      
      todayMultipleAppsController.appResults = todayItem.apps
      todayMultipleAppsController.collectionView.reloadData()
    }
  }
  
  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    backgroundColor = .white
    layer.cornerRadius = 16
        
    let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, todayMultipleAppsController.view])
    stackView.axis = .vertical
    stackView.spacing = 12
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(24)
      make.bottom.trailing.equalToSuperview().offset(-24)
    }
  }
}
