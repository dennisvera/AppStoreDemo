//
//  Reviews.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/8/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
  
  // MARK: - Properties

  let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
  
  // MARK: - Properties

  let entry: [Entry]
}

struct Entry: Decodable {
  
  // MARK: - Properties

  let author: Author
  let title: Label
  let content: Label
  let rating: Label
  
  private enum CodingKeys: String, CodingKey {
    case author
    case title
    case content
    case rating = "im:rating"
  }
}

struct Author: Decodable {

  // MARK: - Properties

  let name: Label
}

struct Label: Decodable {
  
  // MARK: - Properties

  let label: String
}
