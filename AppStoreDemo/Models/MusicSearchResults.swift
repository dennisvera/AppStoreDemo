//
//  MusicSearchResults.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/16/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

import Foundation

struct MusicSearchResults: Decodable {

   // MARK: - Properties

  let resultCount: Int
  let results: [MusicResult]
}

struct MusicResult: Decodable {

   // MARK: - Properties
  
  let trackId: Int
  let trackName: String
  let artistName: String
  let artworkUrl100: String
  let collectionName: String
  let primaryGenreName: String
}
