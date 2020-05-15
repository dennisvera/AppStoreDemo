//
//  TodaySingleAppFullScreenViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class TodaySingleAppFullScreenViewController: UIViewController {
  
  // MARK: - Properties
  
  var dismissHandler: (() ->())?
  var todayItem: TodayItem?
  
  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    return button
  }()
  
  // Disable the scrolling when the Drag Gesture is scrolling upward
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      // HACK: set the scrolling back to true again to enable scrolling
      scrollView.isScrollEnabled = true
    }
  }
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.clipsToBounds = true
    
    setupTableViewController()
    setupDismissButton()
  }
  
  // MARK: - Helper Methods
  
  private func setupTableViewController() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0);
    
    // Remove the status bar
    tableView.contentInsetAdjustmentBehavior = .never
  }
  
  // MARK: - Actions
  
  @objc private func handleDismissView(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
  
  private func setupDismissButton() {
    // BUG: the button is being blocked by the navigationbar, not tappable
    // I set the button top constraint to 140 to get access to the button
    // This needs to be resolved by properly removing the navigationbar
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(140)
      make.trailing.equalToSuperview().offset(-12)
      make.width.equalTo(80)
      make.height.equalTo(40)
    }
    
    dismissButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
  }
}

// MARK: - TableViewDataSource

extension TodaySingleAppFullScreenViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let appFullScreenHeaderCell = TodaySingleAppFullScreenHeaderTableViewCell()
      appFullScreenHeaderCell.todayCell.todayItem = todayItem
      appFullScreenHeaderCell.todayCell.layer.cornerRadius = 0
      appFullScreenHeaderCell.todayCell.backgroundView = nil
        
      // Remove the cell shadow. ClipsToBounds does not allow the the layer shadow to appear.
      appFullScreenHeaderCell.clipsToBounds = true

      return appFullScreenHeaderCell
    }
    
    let appFullScreenCell = TodaySingleAppFullScreenTableViewCell()
    return appFullScreenCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      // Height for top cell
      return TodayCollectionViewController.cellHeight
    }
    
    return UITableView.automaticDimension
  }
}
