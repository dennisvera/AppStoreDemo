//
//  TodaySingleAppFullScreenTableViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodaySingleAppFullScreenTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    
    let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
    
    attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
    
    attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
    
    attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
    
    label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    label.attributedText = attributedText
    label.numberOfLines = 0
    
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
      make.top.equalToSuperview()
      make.bottom.equalToSuperview().offset(-32)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
    }
  }
}
