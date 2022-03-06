//
//  File.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import Combine
import Foundation

enum HTTPMethod: String {
    case GET
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
}

enum EndpointCases: Endpoint {
    case getSubjects
    case getSubject(id: Int)

    case getPartyData(abbreviation: String)

    static let backendBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BACKEND_BASE_URL") as! String
    static let APIBaseUrl = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String

    var httpMethod: HTTPMethod {
        switch self {
        case .getSubjects, .getSubject, .getPartyData:
            return HTTPMethod.GET
        }
    }

    var baseURLString: String {
        switch self {
        case .getSubjects, .getSubject:
            return EndpointCases.backendBaseUrl
        case .getPartyData:
            return Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
        }
    }

    var path: String {
        switch self {
        case .getSubjects:
            return "/subjects/"
        case let .getSubject(id):
            return "/subjects/\(id)/"
        case let .getPartyData(abbreviation):
            return "/party/\(abbreviation)"
        }
    }

    var headers: [String: Any]? {
        switch self {
        case .getSubjects, .getSubject, .getPartyData:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }

    var body: [String: Any]? {
        switch self {
        case .getSubjects, .getSubject, .getPartyData:
            return [:]
        }
    }
}

class ApiManager {
    static let shared = ApiManager()

    private var subscriber = Set<AnyCancellable>()

    func _handleRequest<T: Decodable>(endpoint: EndpointCases, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared

        let url = URL(string: endpoint.url)!
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.httpMethod.rawValue

        endpoint.headers?.forEach { header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        }

        session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case let .failure(error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &subscriber)
    }

    func getSubjects() -> (@escaping (Result<[SubjectListEntry], Error>) -> Void) -> Void {
        { self._handleRequest(endpoint: EndpointCases.getSubjects, completion: $0) }
    }

    func getSubject(endpoint: EndpointCases) -> (@escaping (Result<Subject, Error>) -> Void) -> Void {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    func getPartyData(endpoint: EndpointCases) -> (@escaping (Result<PartyData, Error>) -> Void) -> Void {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }
}
