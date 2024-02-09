//
//  HomeView.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//
import SwiftUI
import NetworkSDK
import UIKit

struct HomeView: View {
    @ObservedObject private var nowPlayingState = MovieType()
    @ObservedObject private var upcomingState = MovieType()
    @ObservedObject private var topRatedState = MovieType()
    @ObservedObject private var popularState = MovieType()
    @ObservedObject private var latestState = MovieType()
    @ObservedObject private var searchModel = MovieSearchModel()
    @State private var selectedMovie: Movie? = nil
    @State private var selectedSearch: Bool = false
    @State private var isDetailPresented = false
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        selectedSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(.subheadline, design: .rounded).weight(.semibold))
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color.white.opacity(0.1), in: Circle())
                            .contentShape(Circle())
                    }
                }
                .padding()
                
                
                Spacer()
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        if nowPlayingState.movies != nil {
                            MovieBackdropCarouselView(title: "Now Playing", movies: nowPlayingState.movies!, selectedMovie: $selectedMovie, isDetailPresented: $isDetailPresented)
                        }
                        if latestState.movies != nil {
                            MovieBackdropCarouselView(title: "Latest", movies: latestState.movies!, selectedMovie: $selectedMovie, isDetailPresented: $isDetailPresented)
                        }
                        if popularState.movies != nil {
                            MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!, selectedMovie: $selectedMovie, isDetailPresented: $isDetailPresented)
                        }
                        if topRatedState.movies != nil {
                            MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!, selectedMovie: $selectedMovie, isDetailPresented: $isDetailPresented)
                        }
                        if upcomingState.movies != nil {
                            MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!, selectedMovie: $selectedMovie, isDetailPresented: $isDetailPresented)
                        }
                        
                        
                    }
                    .background(Color.black)
                    .foregroundColor(.white)
                }
                .fullScreenCover(item: $selectedMovie, onDismiss: {
                    selectedMovie = nil
                }) { movie in
                    MovieDetailView(movieId: movie.id)
                }
                .onAppear {
                    self.nowPlayingState.loadMovies(with: .nowPlaying)
                    self.upcomingState.loadMovies(with: .upcoming)
                    self.topRatedState.loadMovies(with: .topRated)
                    self.popularState.loadMovies(with: .popular)
                    self.latestState.loadMovies(with: .latest)
                }
                .fullScreenCover(isPresented: $selectedSearch, onDismiss: {
                    dismiss()
                }) {
                    SearchView()
                }
            }
            .padding()
        }
    }
}

struct MovieBackdropCarouselView: View {
    
    let title: String
    let movies: [Movie]
    @Binding var selectedMovie: Movie?
    @Binding var isDetailPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        Button(action: {
                            selectedMovie = movie
                            isDetailPresented = true
                        }) {
                            MovieCardCell(movie: movie)
                                .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
        .background(.clear)
    }
}


