//
//  AppsRowCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsRowCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  private let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    imageView.backgroundColor = .purple
    return imageView
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "App Name"
    label.font = .systemFont(ofSize: 20)
    return label
  }()

  private let companyLabel: UILabel = {
    let label = UILabel()
    label.text = "Company Name"
    label.font = .systemFont(ofSize: 13)
    return label
  }()

  private let getBUtton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("GET", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.layer.cornerRadius = 16
    button.backgroundColor = UIColor(white: 0.95, alpha: 1)
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    return button
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
    let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
    labelsStackView.axis = .vertical
    labelsStackView.spacing = 4

    let mainStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getBUtton])
    mainStackView.axis = .horizontal
    mainStackView.alignment = .center
    mainStackView.spacing = 16

    addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
