//
//  AppFullScreenTableViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppFullScreenTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  var dismissHandler: (() ->())?
  var todayItem: TodayItem?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableViewController()
  }
  
  // MARK: - Helper Methods
  
  private func setupTableViewController() {
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
  }
  
  // MARK: - Actions
  
  @objc private func handleDismissView(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
}

// MARK: - TableViewDataSource

extension AppFullScreenTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let appFullScreenHeaderCell = AppFullScreenHeaderTableViewCell()
      appFullScreenHeaderCell.closeButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
      appFullScreenHeaderCell.todayCell.todayItem = todayItem
      return appFullScreenHeaderCell
    }
    
    let appFullScreenCell = AppFullScreenTableViewCell()
    return appFullScreenCell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      // Height for top cell
      return 450
    }
    
    return super.tableView(tableView, heightForRowAt: indexPath)
  }
}
