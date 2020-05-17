//
//  MusicCollectionViewController.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MusicCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let musicCollectionViewCellId = "musicCollectionViewCellId"
  private let musicFooterCollectionReusableViewId = "musicFooterCollectionReusableViewId"
  private var musicResult = [MusicResult]()
  private let searchTerm = "Bjork"
  private var offset = Int()
  private var isPaginating = false
  private var isDonePaginating = false
  
  // MARK: Initialization
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    fecthData()
  }
  
  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    collectionView.backgroundColor = .white
    
    // Register Collection View Cells
    collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: musicCollectionViewCellId)
    
    // Register Collection Footer View
    collectionView.register(MusicFooterCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                            withReuseIdentifier: musicFooterCollectionReusableViewId)
  }
  
  private func fecthData() {
    ServiceClient.shared.fetchItunesMusic(searchTerm: searchTerm, offset: offset) { [weak self] (music, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)
        return
      }
      
      guard let strongSelf = self else { return }
      strongSelf.musicResult = music?.results ?? []
      
      DispatchQueue.main.async {
        strongSelf.collectionView.reloadData()
      }
    }
  }
  
  private func FecthDataPagination(_ indexPath: IndexPath) {
    // Initiate Pagination
    if indexPath.item == musicResult.count - 1 && !isPaginating {
      isPaginating = true
      
      ServiceClient.shared.fetchItunesMusic(searchTerm: searchTerm, offset: musicResult.count) { [weak self] (music, error) in
        if let error = error {
          print("Failed to Fetch Music: ", error)
          return
        }
        guard let strongSelf = self else { return }
        
        if music?.results.count == 0 {
          strongSelf.isDonePaginating = true
        }
        
        // Optional: Itunes API is very fast. Setting a 1 sec delay to display the loader.
        // This should NOT be done in a real app.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          strongSelf.musicResult += music?.results ?? []
          
          DispatchQueue.main.async {
            strongSelf.collectionView.reloadData()
          }
        }
        
        strongSelf.isPaginating = false
      }
    }
  }
}

// MARK: - CollectionViewDataSource

extension MusicCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return musicResult.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musicCollectionViewCellId,
                                                  for: indexPath) as! MusicCollectionViewCell
    cell.music = musicResult[indexPath.item]
    
    FecthDataPagination(indexPath)

    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: musicFooterCollectionReusableViewId,
                                                                 for: indexPath) as! MusicFooterCollectionReusableView
    
    return footer
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension MusicCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    let height: CGFloat = isDonePaginating ? 0 : 100
    
    return .init(width: view.frame.width, height: height)
  }
}
