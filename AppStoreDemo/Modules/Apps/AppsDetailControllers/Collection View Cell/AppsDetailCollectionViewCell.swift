//
//  AppsDetailCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/6/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsDetailCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    imageView.backgroundColor = .red
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "App Name"
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 24)
    return label
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Description"
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  
  let priceButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Free", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.layer.cornerRadius = 16
    button.backgroundColor = #colorLiteral(red: 0.1959072053, green: 0.4716053605, blue: 0.9613705277, alpha: 1)
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    return button
  }()
  
  let whatsNewLabel: UILabel = {
    let label = UILabel()
    label.text = "What's New"
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  let releaseNotesLabel: UILabel = {
    let label = UILabel()
    label.text = "Release notes goes here..."
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 0
    return label
  }()
  
  
  
  // MARK: - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    let topVerticalStackview = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceButton])
    topVerticalStackview.axis = .vertical
    topVerticalStackview.spacing = 6
    topVerticalStackview.alignment = .leading
    topVerticalStackview.setCustomSpacing(10, after: priceButton)
    
    let topHorizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, topVerticalStackview])
    topHorizontalStackView.axis = .horizontal
    topHorizontalStackView.spacing = 12
    
    let verticalStackview = UIStackView(arrangedSubviews: [topHorizontalStackView, whatsNewLabel, releaseNotesLabel])
    verticalStackview.axis = .vertical
    verticalStackview.distribution = .fillProportionally
    verticalStackview.spacing = 0
    
    addSubview(verticalStackview)
    verticalStackview.snp.makeConstraints { make in
      make.edges.equalTo(20)
    }
  }
}
