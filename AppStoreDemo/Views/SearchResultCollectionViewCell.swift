//
//  SearchResultCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .red
    imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    imageView.layer.cornerRadius = 12
    return imageView
  }()

  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "App Name"
    return label
  }()

  let categoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Photos & Videos"
    return label
  }()

  let ratingsLabel: UILabel = {
    let label = UILabel()
    label.text = "92.6M"
    return label
  }()

  let getButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("GET", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.backgroundColor = .darkGray
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let labelsStackView = UIStackView(arrangedSubviews: [
    nameLabel, categoryLabel, ratingsLabel])
    labelsStackView.axis = .vertical

    let stackView = UIStackView(arrangedSubviews: [
      imageView, labelsStackView, getButton
    ])
    stackView.spacing = 12
    stackView.axis = .horizontal
    stackView.alignment = .center

    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    backgroundColor = .yellow
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
