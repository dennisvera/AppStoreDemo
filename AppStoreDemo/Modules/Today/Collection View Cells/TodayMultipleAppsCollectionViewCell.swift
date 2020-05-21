//
//  TodayMultipleAppsCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodayMultipleAppsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  let todayMultipleAppsController = TodayMultipleAppsCollectionViewController(screenType: .shortAppListScreen)

  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = .lightGray
    return label
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 28)
    return label
  }()

  var todayItem: TodayItem? {
    didSet {
      guard let todayItem = todayItem else { return }
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      backgroundColor = todayItem.backgroundColor
      
      todayMultipleAppsController.apps = todayItem.apps
      todayMultipleAppsController.collectionView.reloadData()
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
    
    setCellShadow()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    layer.cornerRadius = 16

    let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, todayMultipleAppsController.view])
    stackView.axis = .vertical
    stackView.spacing = 12
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(24)
      make.bottom.trailing.equalToSuperview().offset(-24)
    }
  }
  
  private func setCellShadow() {
    self.backgroundView = UIView()
    self.backgroundView?.backgroundColor = .white
    self.backgroundView?.layer.cornerRadius = 16
    
    self.backgroundView?.layer.shadowOpacity = 0.1
    self.backgroundView?.layer.shadowRadius = 10
    self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
    self.backgroundView?.layer.shouldRasterize = true
    
    addSubview(self.backgroundView!)
    self.backgroundView?.snp.makeConstraints({ make in
      make.edges.equalToSuperview()
    })
  }
}
