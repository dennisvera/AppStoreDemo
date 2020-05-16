//
//  MusicCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class MusicCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Properties
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Track Name"
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Subtitle text goes here ...."
    label.font = .systemFont(ofSize: 16)
    label.numberOfLines = 2
    return label
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 16
    imageView.image = #imageLiteral(resourceName: "gardenImage")
    imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
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
  
  // MARK: - Helper Methods
  
  private func setupViews() {    
    let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 2
    
    let mainStackView = UIStackView(arrangedSubviews: [imageView, verticalStackView])
    mainStackView.axis = .horizontal
    mainStackView.spacing = 16
    mainStackView.alignment = .center
    
    addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(16)
      make.trailing.bottom.equalToSuperview().offset(-16)
    }
  }
}
