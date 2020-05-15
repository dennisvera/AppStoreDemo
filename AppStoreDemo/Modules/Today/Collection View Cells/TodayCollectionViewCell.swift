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
      guard let todayItem = todayItem else { return }
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      descriptionLabel.text = todayItem.description
      imageView.image = todayItem.image
      backgroundColor = todayItem.backgroundColor
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 1,
                     initialSpringVelocity: 1,
                     options: .curveEaseOut,
                     animations: {
                      self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
      })
    }
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
//    setCellShadow()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    layer.cornerRadius = 16
    
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
  
  // TODO: backgroundView shadow solution is not working due to the background color
  private func setCellShadow() {
    backgroundView = UIView()
    
    addSubview(self.backgroundView!)
    backgroundView?.snp.makeConstraints({ make in
      make.edges.equalToSuperview()
    })
    
    backgroundView?.layer.shadowOpacity = 0.1
    backgroundView?.layer.shadowRadius = 10
    backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
    backgroundView?.layer.cornerRadius = 16
    backgroundColor = .white
    
    
    // The shouldRasterize property helps with slow performace caused by the layer shadow
    // The downside is that the shouldRasterize property makes text and images look blurry and poor
    // The solution is to set the self.backgroundView = UIView() and have the layers set to self.backgroundView?.
    layer.shouldRasterize = true
  }
}
