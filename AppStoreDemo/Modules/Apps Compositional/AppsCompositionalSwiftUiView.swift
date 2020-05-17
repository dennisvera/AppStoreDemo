//
//  AppsCompositionalSwiftUiView.swift
//  AppStoreDemo
//
//  Created by Dennis Vera on 5/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import SwiftUI

struct AppsCompositionalSwiftUiView: UIViewControllerRepresentable {
  typealias UIViewControllerType = UIViewController
  
  func makeUIViewController(context: Context) -> UIViewController {
    let appsCompositionalController = AppsCompositionalCollectionViewController()    
    let navigatioController = UINavigationController(rootViewController: appsCompositionalController)
    return navigatioController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
  }
}

struct AppsCompositionalSwiftUiView_Previews: PreviewProvider {
  static var previews: some View {
    AppsCompositionalSwiftUiView()
      .edgesIgnoringSafeArea(.all)
  }
}
