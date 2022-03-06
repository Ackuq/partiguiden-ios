//
//  HTMLView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//
import SwiftUI
import WebKit

struct HTMLView: View {
    var htmlContent: String

    var body: some View {
        WebView(text: htmlContent)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct WebView: UIViewRepresentable {
    var text: String

    func makeUIView(context _: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(htmlContent: "<bold>Hello World</bold>")
    }
}
