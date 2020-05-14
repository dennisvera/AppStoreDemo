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

  // Itunes API endpoint for Searching Apps
  func fetchApps(searchTerm: String, completion: @escaping (SearchResults?, Error?) -> Void) {
    guard let search = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
    let urlString = "https://itunes.apple.com/search?term=\(search)&entity=software"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }
  
  // Itunes API endpoint for fetching app details
  func fetchApps(id: String, completion: @escaping (SearchResults?, Error?) -> Void) {
    let urlString = "https://itunes.apple.com/lookup?id=\(id)"
    
    fetchGenericJsonData(urlString: urlString, completion: completion)
  }
  
  // Itunes API endpoint for fetching app reviews and ratings
  func fetchAppReview(id: String, completion: @escaping (Reviews?, Error?) -> Void) {
    let urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(id)/sortby=mostrecent/json?l=en&cc=us"
    
    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API endpoint for fetching Free New Apps
  func fetcNewApps(completion: @escaping (AppGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API endpoint for fetching Top Grossing Apps
  func fetchTopGrossingApps(completion: @escaping (AppGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"

    fetchGenericJsonData(urlString: urlString, completion: completion)
  }

  // Itunes API endpoint for fetching Top Free Apps
  func fetchTopFreeApps(completion: @escaping (AppGroup?, Error?) -> Void) {
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
