//
//  WebView.swift
//  hackerNewsPortal
//
//  Created by Admin on 09/09/23.
//

import Foundation
import SwiftUI
import WebKit
struct WebView:UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url:String?
    func makeUIView(context: Context) -> WebView.UIViewType{
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeURL=url{
            if let url = URL(string: safeURL){
//                print("Request sent for URL",url)
                let request = URLRequest(url:url)
                uiView.load(request)
        }
            
        }
    }
}
