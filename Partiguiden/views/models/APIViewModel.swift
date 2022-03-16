//
//  APIViewModel.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-06.
//

import Combine
import SwiftUI

class APIViewModel<ResponseType>: LoadableObject {
    typealias Loader = (@escaping (Result<Output, Error>) -> Void) -> AnyCancellable
    typealias Output = ResponseType
    
    @Published private(set) var state = LoadingState<Output>.loading
    
    var loader: Loader
    var cancellable: AnyCancellable?
    
    init(
        loader: @escaping Loader
    ) {
        self.loader = loader
    }
    
 
    func load(updateState: Bool = true) {
        if updateState {
            state = .fetching
        }
        
        if cancellable != nil {
            cancellable!.cancel()
        }
        cancellable = loader { result in
            self.cancellable = nil
            switch result {
            case let .success(res):
                self.state = .success(res)
            case let .failure(error):
                self.state = .failed(error)
            }
        }
    }
    
    func loadMoreContent(
        newContentLoader: @escaping (@escaping (Result<Output, Error>) -> Void) -> AnyCancellable,
        appendContent: @escaping (Output, Output) -> Output
    ) {
        cancellable = newContentLoader { result in
            self.cancellable = nil
            switch result {
            case let .success(res):
                switch self.state {
                case let .success(previousContent):
                    self.state = .success(appendContent(previousContent, res))
                default:
                    self.state = .success(res)
                }
            case let .failure(error):
                self.state = .failed(error)
            }
        }
    }
}
