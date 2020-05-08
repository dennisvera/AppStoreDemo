//
//  AppsDetailReviewsCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/7/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsDetailReviewsCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Properties
  
  var appsDetailReviewCollectionViewController = AppsDetailReviewsCollectionViewController()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Reviews & Ratings"
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
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
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalTo(20)
    }
    
    addSubview(appsDetailReviewCollectionViewController.view)
    appsDetailReviewCollectionViewController.view.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).inset(-12)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
