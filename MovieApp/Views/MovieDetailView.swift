//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import SwiftUI
import NetworkSDK

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieState()
    
    var body: some View {
        ZStack {
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
                
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            MovieDetailImage(imageLoader: imageLoader, imageURL: movie.backdropURL, movie: movie).opacity(0.5)
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(.subheadline, design: .rounded).weight(.semibold))
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color.white.opacity(0.1), in: Circle())
                            .contentShape(Circle())
                    }
                }
                .padding()
                ScrollView(.vertical, showsIndicators: false) {
                    Text(movie.title)
                        .font(.system(.title, design: .rounded).weight(.semibold))
                        .foregroundColor(.white)
                    HStack(spacing: 10) {
                        Text(movie.genreText)
                        Text("·")
                        Text(movie.yearText)
                        Text(movie.durationText)
                    }
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding()
                    .foregroundColor(.white)
                    
                    Text(movie.overview)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    HStack {
                        if !movie.ratingText.isEmpty {
                            Text(movie.ratingText)
                                .foregroundColor(.yellow)
                        }
                        Text(movie.scoreText)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                    
                    HStack(alignment: .top, spacing: 4) {
                        if movie.cast != nil && movie.cast!.count > 0 {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Starring").font(.headline)
                                ForEach(self.movie.cast!.prefix(9)) { cast in
                                    Text(cast.name)
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        
                        if movie.crew != nil && movie.crew!.count > 0 {
                            VStack(alignment: .leading, spacing: 4) {
                                if movie.directors != nil && movie.directors!.count > 0 {
                                    Text("Director(s)").font(.headline)
                                    ForEach(self.movie.directors!.prefix(2)) { crew in
                                        Text(crew.name)
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                    }
                                }
                                
                                if movie.producers != nil && movie.producers!.count > 0 {
                                    Text("Producer(s)").font(.headline)
                                        .padding(.top)
                                    ForEach(self.movie.producers!.prefix(2)) { crew in
                                        Text(crew.name)
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                    }
                                }
                                
                                if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                                    Text("Screenwriter(s)").font(.headline)
                                        .padding(.top)
                                    ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                        Text(crew.name)
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                    }
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    Divider()
                    VStack(alignment: .leading, spacing: 8){
                        if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                            Text("Trailers").font(.system(size: 24, weight: .semibold, design: .rounded))
                            ForEach(movie.youtubeTrailers!) { trailer in
                                Button(action: {
                                    self.selectedTrailer = trailer
                                }) {
                                    HStack {
                                        Text(trailer.name)
                                        Spacer()
                                        Image(systemName: "play.circle.fill")
                                            .foregroundColor(Color(UIColor.red))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(16)
                .foregroundColor(.white)
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            WebView(url: trailer.youtubeURL!)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


