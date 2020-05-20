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
  let tableView = UITableView(frame: .zero, style: .plain)
  
  private let floatingContainerView = UIView()
  private let floatingContainerViewHeight: CGFloat = 90
  private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 16
    imageView.widthAnchor.constraint(equalToConstant: 68).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 68).isActive = true
    return imageView
  }()
  
  private let getBUtton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("GET", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .darkGray
    button.layer.cornerRadius = 16
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    return button
  }()
  
  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    return button
  }()
    
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.clipsToBounds = true
    
    setupTableViewController()
    setupDismissButton()
    setupFloatingContainerView()
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
    let statusBarFrameHeight = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: statusBarFrameHeight, right: 0);
  
    // Remove the status bar
    tableView.contentInsetAdjustmentBehavior = .never
  }
  
  private func setupDismissButton() {
    view.addSubview(dismissButton)
    dismissButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.trailing.equalToSuperview().offset(-12)
      make.width.equalTo(80)
      make.height.equalTo(40)
    }
    
    dismissButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
  }
  
  private func setupFloatingContainerView() {
    floatingContainerView.clipsToBounds = true
    floatingContainerView.layer.cornerRadius = 16
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
    
    view.addSubview(floatingContainerView)
    floatingContainerView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(floatingContainerViewHeight)
      make.height.equalTo(90)
    }
    
    floatingContainerView.addSubview(blurVisualEffectView)
    blurVisualEffectView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    categoryLabel.text = todayItem?.category
    titleLabel.text = todayItem?.title
    imageView.image = todayItem?.image

    let verticalView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel])
    verticalView.axis = .vertical
    verticalView.spacing = 4
    
    let mainStackView = UIStackView(arrangedSubviews: [imageView, verticalView, getBUtton])
    mainStackView.axis = .horizontal
    mainStackView.spacing = 16
    mainStackView.alignment = .center
    
    floatingContainerView.addSubview(mainStackView)
    mainStackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
  }
  
  // MARK: - Actions
  
  @objc private func handleDismissView(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
  
  @objc fileprivate func handleViewTap() {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    let statusBarFrameHeight = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
                    let floatingContainerHeight = -self.floatingContainerViewHeight - statusBarFrameHeight
                    self.floatingContainerView.transform = .init(translationX: 0, y: floatingContainerHeight)
    })
  }
  
  // Disable the scrolling when the Drag Gesture is scrolling upward
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      // HACK: set the scrolling back to true again to enable scrolling
      scrollView.isScrollEnabled = true
    }
    
    let statusBarFrameHeight = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    let translationY = -floatingContainerViewHeight - statusBarFrameHeight
    let transform = scrollView.contentOffset.y > 0 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut,
                   animations: {
                    self.floatingContainerView.transform = transform
    })
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
