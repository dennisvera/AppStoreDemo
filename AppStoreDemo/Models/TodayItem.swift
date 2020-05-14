//
//  TodayItem.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

struct TodayItem {
  
  // MARK: - Properties
  
  let category: String
  let title: String
  let image: UIImage
  let description: String
  let backgroundColor: UIColor
  
  let cellType: CellType
  let apps: [FeedResult]
  
  enum CellType: String {
    case single
    case multiple
  }
}
