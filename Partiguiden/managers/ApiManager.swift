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
    var queryItems: [URLQueryItem] { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        var urlComponents = URLComponents(string: baseURLString + path)!
        urlComponents.queryItems = queryItems
        return urlComponents.url!.absoluteString
    }
}

enum EndpointCases: Endpoint {
    case getSubjects
    case getSubject(id: Int)

    case getPartyData(abbreviation: String)

    case getDecisions(search: String, org: String, page: Int)

    static let backendBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BACKEND_BASE_URL") as! String
    static let APIBaseUrl = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String

    var httpMethod: HTTPMethod {
        switch self {
        case .getSubjects, .getSubject, .getPartyData, .getDecisions:
            return HTTPMethod.GET
        }
    }

    var baseURLString: String {
        switch self {
        case .getSubjects, .getSubject:
            return EndpointCases.backendBaseUrl
        case .getPartyData, .getDecisions:
            return EndpointCases.APIBaseUrl
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
        case .getDecisions:
            return "/decisions"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .getSubjects, .getSubject, .getPartyData:
            return []
        case let .getDecisions(search, org, page):
            let searchQuery = URLQueryItem(name: "search", value: search)
            let orgQuery = URLQueryItem(name: "org", value: org)
            let pageQuery = URLQueryItem(name: "page", value: String(page))
            return [searchQuery, orgQuery, pageQuery]
        }
    }

    var headers: [String: Any]? {
        switch self {
        case .getSubjects, .getSubject, .getPartyData, .getDecisions:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }

    var body: [String: Any]? {
        switch self {
        case .getSubjects, .getSubject, .getPartyData, .getDecisions:
            return [:]
        }
    }
}

class ApiManager {
    static let shared = ApiManager()

    func _handleRequest<T: Decodable>(endpoint: EndpointCases, completion: @escaping (Result<T, Error>) -> Void) -> AnyCancellable {
        let session = URLSession.shared

        let url = URL(string: endpoint.url)!
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.httpMethod.rawValue

        endpoint.headers?.forEach { header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        }

        let request = session.dataTaskPublisher(for: urlRequest)
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

        return request
    }

    func getSubjects() -> (@escaping (Result<[SubjectListEntry], Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: EndpointCases.getSubjects, completion: $0) }
    }

    func getSubject(endpoint: EndpointCases) -> (@escaping (Result<Subject, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    func getPartyData(endpoint: EndpointCases) -> (@escaping (Result<PartyData, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    func getDecisions(endpoint: EndpointCases) -> (@escaping (Result<DecisionsResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }
}
