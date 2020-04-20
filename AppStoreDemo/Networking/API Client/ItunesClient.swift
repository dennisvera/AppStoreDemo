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

  func fetcNewApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"

    fetchAppGroup(urlString: urlString, completion: completion)
  }

  func fetcTopGrossingApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"

    fetchAppGroup(urlString: urlString, completion: completion)
  }

  func fetcTopFreeApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"

    fetchAppGroup(urlString: urlString, completion: completion)
  }

  // MARK: - API Helper Method

  private func fetchAppGroup(urlString: String, completion: @escaping (FeedGroup?, Error?) -> Void) {
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

  func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
    let urlString = "https://api.letsbuildthatapp.com/appstore/social"
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
        let socialApps = try decoder.decode([SocialApp].self, from: data)

        // Invoke Handler
        completion(socialApps, nil)

      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)

        // Invoke Handler
        completion([], jsonError)
      }
    }.resume()
  }
}
