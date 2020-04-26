//
//  ServiceClient.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 4/13/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

class ServiceClient {

  // MARK: - Properties

  static let shared = ServiceClient()

  // MARK: - Public API

  // // Itunes API for Searching Apps
  func fetchApps(searchTerm: String, completion: @escaping (SearchResults?, Error?) -> Void) {
    guard let search = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
    let urlString = "https://itunes.apple.com/search?term=\(search)&entity=software"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API for fetching Free New Apps
  func fetcNewApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API for fetching Top Grossing Apps
  func fetcTopGrossingApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API for fetching Top Free Apps
  func fetcTopFreeApps(completion: @escaping (FeedGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // LetsBuildThatApp API for social feeds
  func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
    let urlString = "https://api.letsbuildthatapp.com/appstore/social"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // MARK: - API Helper Method

  private func fetchGenericJsonData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
    guard let url = URL(string: urlString) else { return }

    // Initialize and Initiate Data Task
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print("Failed to Fetch Apps: ", error)

        // Invoke Handler
        completion(([] as! T), nil)
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
        let socialApps = try decoder.decode(T.self, from: data)

        // Invoke Handler
        completion(socialApps, nil)

      } catch let jsonError {
        print("Failed to Decode JSON: ", jsonError)

        // Invoke Handler
        completion(([] as! T), jsonError)
      }
    }.resume()
  }
}
