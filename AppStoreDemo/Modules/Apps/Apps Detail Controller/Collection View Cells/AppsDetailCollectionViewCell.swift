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
  
  private let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 16
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 24)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  
  private let priceButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.layer.cornerRadius = 32 / 2
    button.backgroundColor = #colorLiteral(red: 0.1959072053, green: 0.4716053605, blue: 0.9613705277, alpha: 1)
    return button
  }()
  
  private let whatsNewLabel: UILabel = {
    let label = UILabel()
    label.text = "What's New"
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let releaseNotesLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 18)
    return label
  }()
  
  var app: Result? {
    didSet {
      guard let app = app else { return }
      appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
      nameLabel.text = app.trackName
      descriptionLabel.text = app.description
      releaseNotesLabel.text = app.releaseNotes
      priceButton.setTitle(app.formattedPrice, for: .normal)
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
    addSubview(appIconImageView)
    appIconImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalTo(140)
    }
    
    addSubview(priceButton)
    priceButton.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
      make.width.equalTo(80)
      make.height.equalTo(32)
    }
    
    let topVerticalStackview = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceButton])
    topVerticalStackview.axis = .vertical
    topVerticalStackview.spacing = 6
    topVerticalStackview.alignment = .leading
    
    let topHorizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, topVerticalStackview])
    topHorizontalStackView.axis = .horizontal
    topHorizontalStackView.spacing = 12
    
    let verticalStackview = UIStackView(arrangedSubviews: [topHorizontalStackView, whatsNewLabel, releaseNotesLabel])
    verticalStackview.axis = .vertical
    verticalStackview.spacing = 12

    addSubview(verticalStackview)
    verticalStackview.snp.makeConstraints { make in
      make.top.leading.equalTo(20)
      make.trailing.bottom.equalToSuperview().offset(-20)
    }
  }
}
