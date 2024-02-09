//
//  SearchView.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var searchModel = MovieSearchModel()
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
                NavigationView {
                    List {
                        SearchBarView(placeholder: "Search movies", text: self.$searchModel.query)
                            .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        if self.searchModel.movies != nil {
                            ForEach(self.searchModel.movies!) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                        Text(movie.yearText)
                                    }
                                }
                            }
                        }
                        
                    }
                    .onAppear {
                        self.searchModel.startObserve()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
