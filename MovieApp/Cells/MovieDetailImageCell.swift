//
//  MovieDetailImageCell.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import SwiftUI
import NetworkSDK

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    let movie: Movie
    @State var gradient: [Color] = [Color(hex: "100A29").opacity(0), Color(hex: "100A29"), Color(hex: "100A29"), Color(hex: "100A29")]
    var body: some View {
        ZStack(alignment: .bottomLeading)  {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}
