//
//  WebView.swift
//  MovieApp
//
//  Created by Nitin Kumar on 09/02/24.
//

import Foundation
import SafariServices
import SwiftUI

struct WebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}
