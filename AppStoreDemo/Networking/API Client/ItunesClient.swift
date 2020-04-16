//
//  ItunesClient.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

class ItunesClient {

  static let shared = ItunesClient()

  func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
    guard let search = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
    let urlString = "https://itunes.apple.com/search?term=\(search)&entity=software"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)
        completion([], nil)
        return
      }

      guard let data = data else { return }

      do {
        let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)

        completion(searchResult.results, nil)

      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)
        completion([], jsonError)
      }
    }.resume()
  }
}
