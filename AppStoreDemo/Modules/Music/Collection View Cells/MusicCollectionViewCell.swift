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
  
  private let trackLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
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
  
  var music: MusicResult? {
    didSet {
      guard let music = music else { return }
      trackLabel.text = music.trackName
      descriptionLabel.text = "\(music.artistName) • \(music.collectionName) • \(music.primaryGenreName)"
      imageView.sd_setImage(with: URL(string: music.artworkUrl100))
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
    let verticalStackView = UIStackView(arrangedSubviews: [trackLabel, descriptionLabel])
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
