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
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "gardenImage")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
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
    backgroundColor = .white
    layer.cornerRadius = 16
    
    addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.centerY.centerX.equalTo(self)
      make.width.height.equalTo(250)
    }
  }
}
