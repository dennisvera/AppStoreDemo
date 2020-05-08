//
//  SearchResults.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {

   // MARK: - Properties

  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {

   // MARK: - Properties
  
  let trackId: Int
  let trackName: String
  let primaryGenreName: String
  var averageUserRating: Float?
  let artworkUrl100: String
  let screenshotUrls: [String]
  
  var formattedPrice: String?
  let description: String
  var releaseNotes: String?
}
