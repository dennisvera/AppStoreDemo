//
//  SearchResults.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/12/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {
  let trackName: String
  let primaryGenreName: String
}
