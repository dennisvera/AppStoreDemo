//
//  SocialApp.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/19/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct SocialApp: Decodable, Hashable {

  // MARK: - Properties

  let id: String
  let name: String
  let tagline: String
  let imageUrl: String
}
