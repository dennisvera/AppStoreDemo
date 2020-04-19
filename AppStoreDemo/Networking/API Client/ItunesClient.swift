//
//  ItunesClient.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

class ItunesClient {

  // MARK: - Properties

  static let shared = ItunesClient()

  // MARK: - Public API

  func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> Void) {
    guard let search = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
    let urlString = "https://itunes.apple.com/search?term=\(search)&entity=software"
    guard let url = URL(string: urlString) else { return }

    // Initialize and Initiate Data Task
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)

        // Invoke Handler
        completion([], nil)
        return
      }

      guard let data = data else { return }

      do {
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Decode JSON Response
        let searchResult = try decoder.decode(SearchResults.self, from: data)

        // Invoke Handler
        completion(searchResult.results, nil)

      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)

        // Invoke Handler
        completion([], jsonError)
      }
    }.resume()
  }

  // MARK: - Public API

  func fetchMusic(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
    guard let url = URL(string: urlString) else { return }

    // Initialize and Initiate Data Task
    URLSession.shared.dataTask(with: url) { (data, rersponse, error) in
      if let error = error {
        print("Failed to Fetch Music: ", error)

        // Invoke Handler
        completion(nil, error)
        return
      }

      guard let data = data else { return }

      do {
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Decode JSON Response
        let feedGroup = try decoder.decode(FeedGroup.self, from: data)

        // Invoke Handler
        completion(feedGroup, nil)

      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)

        // Invoke Handler
        completion(nil, jsonError)
      }

    }.resume()
  }
}
