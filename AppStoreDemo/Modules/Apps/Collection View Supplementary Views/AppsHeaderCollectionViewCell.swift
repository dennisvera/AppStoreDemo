//
//  AppsHeaderCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsHeaderCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  let companyLabel: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.font = .boldSystemFont(ofSize: 14)
    return label
  }()

  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 24)
    return label
  }()

  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()


  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Helper Methods

  private func setupViews() {
    let mainStackView = UIStackView(arrangedSubviews: [companyLabel, descriptionLabel, imageView])
    mainStackView.spacing = 12
    mainStackView.axis = .vertical

    addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.top.equalTo(16)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
