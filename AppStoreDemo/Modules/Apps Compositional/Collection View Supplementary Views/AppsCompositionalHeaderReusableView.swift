//
//  AppsCompositionalHeaderReusableView.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsCompositionalHeaderReusableView: UICollectionReusableView {
  
  // MARK: - Properties

  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 28)
    return label
  }()
  
  private let separatorLineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
    return view
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
    addSubview(separatorLineView)
    separatorLineView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
        make.height.equalTo(0.5)
    }
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(separatorLineView.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview()
    }
  }
}

