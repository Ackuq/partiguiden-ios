//
//  APIViewModel.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-06.
//

import Foundation

class APIViewModel<ResponseType>: LoadableObject {
    typealias Output = ResponseType

    @Published private(set) var state = LoadingState<Output>.loading

    private let loader: (@escaping (Result<Output, Error>) -> Void) -> Void

    init(
        loader: @escaping (@escaping (Result<Output, Error>) -> Void) -> Void
    ) {
        self.loader = loader
    }

    func load() {
        loader { result in
            switch result {
            case let .success(res):
                self.state = .success(res)
            case let .failure(error):
                self.state = .failed(error)
            }
        }
    }
}
