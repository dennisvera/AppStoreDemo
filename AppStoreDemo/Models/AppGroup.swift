//
//  AppGroup.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/19/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {

  // MARK: - Properties

  let feed: Feed
}

struct Feed: Decodable {

  // MARK: - Properties

  let title: String
  let results: [FeedResult]
}

struct FeedResult: Decodable {

  // MARK: - Properties

  let id: String
  let artistName: String
  let name: String
  let artworkUrl100: String
}
