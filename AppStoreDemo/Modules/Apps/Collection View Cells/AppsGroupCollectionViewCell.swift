//
//  AppsGroupCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsGroupCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  let horizontalViewController = AppsHorizontalCollectionViewController()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 30)
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
      make.top.equalToSuperview().offset(16)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(0.5)
    }
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(separatorLineView.snp.bottom).offset(20)
      make.leading.equalTo(16)
    }
    
    addSubview(horizontalViewController.view)
    horizontalViewController.view.backgroundColor = .red
    horizontalViewController.view.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(24)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
