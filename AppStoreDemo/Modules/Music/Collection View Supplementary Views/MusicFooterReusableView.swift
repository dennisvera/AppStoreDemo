//
//  MusicFooterCollectionReusableView.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MusicFooterCollectionReusableView: UICollectionReusableView {
  
  // MARK: - Properties
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Loading more ..."
    label.font = .boldSystemFont(ofSize: 16)
    return label
  }()
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
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
    backgroundColor = UIColor(white: 0.1, alpha: 0.1)
    
    let stackView = UIStackView(arrangedSubviews: [activityIndicatorView, titleLabel])
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 2
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
      make.top.equalToSuperview().offset(14)
      make.width.equalTo(200)
    }
  }
}
