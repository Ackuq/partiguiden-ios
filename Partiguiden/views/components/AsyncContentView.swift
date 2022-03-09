//
//  ContentViewModel.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-06.
//

import SwiftUI

enum LoadingState<Value> {
    case loading
    case failed(Error)
    case success(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source

    var content: (Source.Output) -> Content

    init(
        source: Source,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .loading:
            LoadingView().onAppear(perform: source.load)
        case let .failed(error):
            // TODO: Proper error view
            Text("Error \(error.localizedDescription)!")
        // ErrorView(error: error, retryHandler: source.load)
        case let .success(res):
            content(res)
        }
    }
}
