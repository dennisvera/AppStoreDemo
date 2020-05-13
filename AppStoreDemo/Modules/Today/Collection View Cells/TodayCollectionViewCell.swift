//
//  TodayCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/8/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodayCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 28)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.numberOfLines = 3
    return label
  }()
  
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  var topConstraint: NSLayoutConstraint!
  
  var todayItem: TodayItem? {
    didSet {
      guard let item = todayItem else { return }
      categoryLabel.text = item.category
      titleLabel.text = item.title
      descriptionLabel.text = item.description
      imageView.image = item.image
      backgroundColor = item.backgroundColor
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
    layer.cornerRadius = 16
    clipsToBounds = true
    
    // ImageViews do not size properly on StackViews,
    // wrapping the ImageView in a UIView scales better in the StackView.
    let imageContainerView = UIView()
    imageContainerView.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
      make.width.height.equalTo(240)
    }
    
    let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel])
    stackView.axis = .vertical
    stackView.spacing = 8
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.bottom.trailing.equalToSuperview().offset(-24)
    }
    
    topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
    topConstraint.isActive = true
  }
}
