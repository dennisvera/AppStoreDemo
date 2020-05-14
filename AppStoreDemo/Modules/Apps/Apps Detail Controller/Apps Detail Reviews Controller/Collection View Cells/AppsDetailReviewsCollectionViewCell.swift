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
  
  private let separatorLineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
    return view
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
    addSubview(separatorLineView)
    separatorLineView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(0.5)
    }
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(separatorLineView.snp.bottom).offset(20)
      make.leading.trailing.equalTo(20)
    }
    
    addSubview(appsDetailReviewCollectionViewController.view)
    appsDetailReviewCollectionViewController.view.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(12)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
