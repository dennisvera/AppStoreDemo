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
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableViewController()
  }
  
  // MARK: - Helper Methods
  
  private func setupTableViewController() {
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    tableView.separatorStyle = .none
  }
}

// MARK: - TableViewDataSource

extension AppFullScreenTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      // Hack to return a Collection View Cell inside the Table View Cell
      // TODO: Look for a better solution
      let tableViewCell = UITableViewCell()
      let todayCell = TodayCollectionViewCell()
      todayCell.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
      tableViewCell.addSubview(todayCell)
      todayCell.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
      return tableViewCell
    } else {
      let appFullScreenCell = AppFullScreenTableViewCell()
      return appFullScreenCell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 450
  }
}
