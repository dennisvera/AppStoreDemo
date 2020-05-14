//
//  AppFullScreenHeaderTableViewCell.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppFullScreenHeaderTableViewCell: UITableViewCell {
  
  // MARK: - Properties
    
  let todayCell = TodayCollectionViewCell()
  
  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    return button
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
    addSubview(todayCell)
    todayCell.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    addSubview(dismissButton)
    dismissButton.snp.makeConstraints { make in
      // BUG: the button is being blocked by the navigationbar, not tappable
      // I set the button top constraint to 140 to get access to the button
      // This needs to be resolved by properly removing the navigationbar
      make.top.equalToSuperview().offset(140)
      make.trailing.equalToSuperview().offset(-12)
      make.width.equalTo(80)
      make.height.equalTo(38)
    }
  }
}