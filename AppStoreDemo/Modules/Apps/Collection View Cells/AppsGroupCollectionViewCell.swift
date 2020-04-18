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

  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "App Section"
    label.font = .boldSystemFont(ofSize: 30)
    return label
  }()

  let horizontalViewController = AppsHorizontalCollectionViewController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods

  fileprivate func setupViews() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalTo(16)
    }

    addSubview(horizontalViewController.view)
    horizontalViewController.view.backgroundColor = .red
    horizontalViewController.view.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
