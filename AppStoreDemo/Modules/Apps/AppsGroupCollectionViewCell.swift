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

  let titleLabels = UILabel(text: "App Section",
                            font: .boldSystemFont(ofSize: 30))

  let horizontalViewController = AppsHorizontalViewController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .yellow
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods

  func setupViews() {

    addSubview(titleLabels)
    titleLabels.snp.makeConstraints { make in
      make.top.leading.equalToSuperview()
    }

    addSubview(horizontalViewController.view)
    horizontalViewController.view.backgroundColor = .red
    horizontalViewController.view.snp.makeConstraints { make in
      make.top.equalTo(titleLabels.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
