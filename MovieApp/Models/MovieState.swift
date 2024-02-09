//
//  MovieState.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import SwiftUI
import NetworkSDK

class MovieState: ObservableObject {
    private let networkService: NetworkService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(networkService: NetworkService = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.networkService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}

