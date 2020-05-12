//
//  AppsDetailReviewsAndRatingsCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/7/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class AppsDetailReviewsAndRatingsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.textColor = .black
    label.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    return label
  }()
  
  let authorLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textColor = .lightGray
    label.textAlignment = .right
    return label
  }()
  
  let ratingLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let reviewLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    label.numberOfLines = 8
    label.textColor = .black
    return label
  }()
  
  let ratingStackView: UIStackView = {
    var arrangedSubViews = [UIView]()
    (0..<5).forEach { _ in
      let imageView = UIImageView(image: #imageLiteral(resourceName: "starImage"))
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleAspectFill
      imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
      imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
      
      arrangedSubViews.append(imageView)
    }
    
    // The empty view constraints the stackview from stretching
    // the images when there are not enough images to fill the stackview.
    let emptyView = UIView()
    arrangedSubViews.append(emptyView)
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
    stackView.axis = .horizontal
    stackView.spacing = 1
    return stackView
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
    backgroundColor = #colorLiteral(red: 0.9462522864, green: 0.9404786825, blue: 0.9754144549, alpha: 1)
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let horizontaStackview = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
    horizontaStackview.axis = .horizontal
    
    let emptyView = UIView()
    let mainStackView = UIStackView(arrangedSubviews: [horizontaStackview, ratingStackView, reviewLabel, emptyView])
    mainStackView.axis = .vertical
    mainStackView.spacing = 12
    mainStackView.setCustomSpacing(12, after: ratingStackView)

    addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.top.leading.equalTo(20)
      make.trailing.bottom.equalTo(-20)
    }
  }    
}
