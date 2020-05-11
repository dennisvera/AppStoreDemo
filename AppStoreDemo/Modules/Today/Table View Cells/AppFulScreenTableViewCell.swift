//
//  AppFullScreenTableViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppFullScreenTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Decription Label"
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  
  // MARK: Initialization
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalTo(24)
    }
  }
}
