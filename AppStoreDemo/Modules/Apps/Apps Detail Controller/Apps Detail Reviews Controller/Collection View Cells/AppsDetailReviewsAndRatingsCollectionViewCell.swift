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
    label.text = "Title"
    label.font = .boldSystemFont(ofSize: 18)
    label.textColor = .black
    return label
  }()
  
  let authorLabel: UILabel = {
    let label = UILabel()
    label.text = "Author Name"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .lightGray
    return label
  }()
  
   let starsLabel: UILabel = {
    let label = UILabel()
    label.text = "Star"
    label.font = .systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  let reviewLabel: UILabel = {
    let label = UILabel()
    label.text = "review Label\n review Label\n review Label\n review Label\n review Label\n review Label\n"
    label.font = .systemFont(ofSize: 16)
    label.numberOfLines = 0
    label.textColor = .black
    return label
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
      
      let emptyView = UIView()
      let horizontaStackview = UIStackView(arrangedSubviews: [titleLabel, emptyView, authorLabel])
      horizontaStackview.axis = .horizontal
      
      let mainStackView = UIStackView(arrangedSubviews: [horizontaStackview, starsLabel, reviewLabel])
      mainStackView.axis = .vertical
      mainStackView.spacing = 2
      
      addSubview(mainStackView)
      mainStackView.snp.makeConstraints { make in
        make.top.leading.equalTo(20)
        make.trailing.bottom.equalTo(-20)
      }
  }    
}
