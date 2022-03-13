//
//  HTMLView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    var html: String

    func makeUIView(context _: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(html: "<html><body><h1>Hello World</h1></body></html>")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
