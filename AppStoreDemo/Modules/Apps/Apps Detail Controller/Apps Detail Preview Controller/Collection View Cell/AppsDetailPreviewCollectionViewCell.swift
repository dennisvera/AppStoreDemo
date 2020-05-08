//
//  AppsDetailPreviewCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/7/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsDetailPreviewCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  var appsDetailPreviewCollectionViewController = AppsDetailPreviewCollectionViewController()
  private let previewLabel: UILabel = {
    let label = UILabel()
    label.text = "Preview"
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = .black
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
    addSubview(previewLabel)
    previewLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalTo(20)
    }
    
    addSubview(appsDetailPreviewCollectionViewController.view)
    appsDetailPreviewCollectionViewController.view.snp.makeConstraints { make in
      make.top.equalTo(previewLabel.snp.bottom).inset(-20)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
