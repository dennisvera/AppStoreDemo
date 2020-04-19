//
//  AppsHeaderReusableView.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/18/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SnapKit

class AppsHeaderReusableView: UICollectionReusableView {

  // MARK: - Properties

  private let appsHeaderHorizontalViewController = AppsHeaderHorizontalCollectionViewController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(appsHeaderHorizontalViewController.view)
    appsHeaderHorizontalViewController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
