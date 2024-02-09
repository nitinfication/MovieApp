//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import SwiftUI
import NetworkSDK

@main
struct MovieAppApp: App {
    init() {
        if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let apiKey = keys["API Key"] as? String {
            NetworkManager.shared.setAPIKey(apiKey)
        } else {
            print("API Key is missing!")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
