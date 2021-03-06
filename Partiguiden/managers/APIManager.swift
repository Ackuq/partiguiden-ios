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
        let formattedPath = path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        var urlComponents = URLComponents(string: baseURLString + formattedPath)!
        urlComponents.queryItems = queryItems
        return urlComponents.url!.absoluteString
    }
}

enum EndpointCases: Endpoint {
    // Subject data
    case getSubjects
    case getSubject(id: Int)
    // Party data
    case getPartyData(abbreviation: String)
    // Parliament decisions
    case getDecisions(search: String, org: String, page: Int)
    // Parliament votes
    case getVotes(search: String, org: String, page: Int)
    case getVote(voteId: String, propositions: Int)
    // Documents
    case getDocument(id: String)

    static let backendBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BACKEND_BASE_URL") as! String
    static let APIBaseUrl = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String

    var httpMethod: HTTPMethod {
        return HTTPMethod.GET
    }

    var baseURLString: String {
        switch self {
        case .getSubjects, .getSubject:
            return EndpointCases.backendBaseUrl
        default:
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
        case let .getDocument(id):
            return "/document/\(id)/json"
        case .getVotes:
            return "/vote"
        case let .getVote(id, proposition):
            return "/vote/\(id)/\(proposition)"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .getDecisions(search, org, page), let .getVotes(search, org, page):
            let searchQuery = URLQueryItem(name: "search", value: search)
            let orgQuery = URLQueryItem(name: "org", value: org)
            let pageQuery = URLQueryItem(name: "page", value: String(page))
            return [searchQuery, orgQuery, pageQuery]
        default:
            return []
        }
    }

    var headers: [String: Any]? {
        switch self {
        default:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }

    var body: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
}

class APIManager {
    static func _handleRequest<T: Decodable>(endpoint: EndpointCases, completion: @escaping (Result<T, Error>) -> Void) -> AnyCancellable {
        let session = URLSession.shared

        let url = URL(string: endpoint.url)!
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.httpMethod.rawValue

        endpoint.headers?.forEach { header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        }
        debugPrint("Request to \(urlRequest.url!.absoluteURL)")
        let request = session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case let .failure(error):
                    debugPrint(error)
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { result in
                completion(.success(result))
            }

        return request
    }

    static func getSubjects(endpoint: EndpointCases = EndpointCases.getSubjects) -> (@escaping (Result<[SubjectListEntryResponse], Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    static func getSubject(endpoint: EndpointCases) -> (@escaping (Result<SubjectResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    static func getPartyData(endpoint: EndpointCases) -> (@escaping (Result<PartyDataResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    static func getDecisions(endpoint: EndpointCases) -> (@escaping (Result<DecisionsResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    static func getDocument(endpoint: EndpointCases) -> (@escaping (Result<DocumentResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }

    static func getVotes(endpoint: EndpointCases) -> (@escaping (Result<VoteListResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }
    
    static func getVote(endpoint: EndpointCases) -> (@escaping (Result<VoteResponse, Error>) -> Void) -> AnyCancellable {
        { self._handleRequest(endpoint: endpoint, completion: $0) }
    }
}
