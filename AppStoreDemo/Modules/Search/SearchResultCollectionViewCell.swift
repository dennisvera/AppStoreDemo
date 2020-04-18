//
//  SearchResultCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 12
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
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
    button.backgroundColor = UIColor(white: 0.95, alpha: 1)
    button.layer.cornerRadius = 16
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    return button
  }()

  lazy var screenshot1ImageView = createScreenShotImage()
  lazy var screenshot2ImageView = createScreenShotImage()
  lazy var screenshot3ImageView = createScreenShotImage()

  var searchResult: Result! {
    didSet {
      nameLabel.text = searchResult.trackName
      categoryLabel.text = searchResult.primaryGenreName
      ratingsLabel.text = "\(searchResult.averageUserRating ?? 0)"

      let url = URL(string: searchResult.artworkUrl100)
      appIconImageView.sd_setImage(with: url)

      screenshot1ImageView.sd_setImage(with: URL(string: searchResult.screenshotUrls[0]))

      if searchResult.screenshotUrls.count > 1 {
        screenshot2ImageView.sd_setImage(with: URL(string: searchResult.screenshotUrls[1]))
      }

      if searchResult.screenshotUrls.count > 2 {
        screenshot3ImageView.sd_setImage(with: URL(string: searchResult.screenshotUrls[2]))
      }
    }
  }

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    // Setup Views
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Helper Methods

  private func setupViews() {
    let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
    labelsStackView.axis = .vertical

    let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
    infoTopStackView.spacing = 12
    infoTopStackView.axis = .horizontal
    infoTopStackView.alignment = .center

    let screenShotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView,
                                                              screenshot2ImageView,
                                                              screenshot3ImageView])
    screenShotsStackView.axis = .horizontal
    screenShotsStackView.spacing = 12
    screenShotsStackView.distribution = .fillEqually

    let mainStackView = UIStackView(arrangedSubviews: [infoTopStackView, screenShotsStackView])
    mainStackView.axis = .vertical
    mainStackView.spacing = 6

    addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(16)
      make.bottom.trailing.equalToSuperview().offset(-16)
    }
  }

  private func createScreenShotImage() -> UIImageView {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 0.5
    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    return imageView
  }
}
