//
//  File.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import Foundation


enum HTTPMethod: String {
    case GET = "GET"
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
    
    static let backendBaseUrl = Bundle.main.object(forInfoDictionaryKey: "BACKEND_BASE_URL") as! String
    static let APIBaseUrl = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getSubjects, .getSubject:
            return HTTPMethod.GET
        }
    }
    
    var baseURLString: String {
        switch self {
        case .getSubjects, .getSubject:
            return EndpointCases.backendBaseUrl
            // case
            //    return Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
        }
    }
    
    var path: String {
        switch self {
        case .getSubjects:
            return "/subjects/"
        case .getSubject(let id):
            return "/subjects/\(id)/"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getSubjects, .getSubject:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getSubjects, .getSubject:
            return [:]
        }
    }
}


class ApiManager {
    static let shared = ApiManager()
    
    func _handleRequest<T: Decodable>(endpoint: EndpointCases, returnType: T.Type, completion: @escaping (T) -> Void
    ) {
        let session = URLSession.shared
        
        let url = URL(string: endpoint.url)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        endpoint.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let results = try! JSONDecoder().decode(returnType.self, from: data!)
            DispatchQueue.main.async {
                completion(results)
            }
        }
        
        task.resume()
    }
    
    func getSubjects(completion: @escaping ([SubjectListEntry]) -> Void) {
        _handleRequest(endpoint: EndpointCases.getSubjects, returnType: [SubjectListEntry].self, completion: completion)
    }
    
    func getSubject(endpoint: EndpointCases, completion: @escaping (Subject) -> Void) {
        _handleRequest(endpoint: endpoint, returnType: Subject.self, completion: completion)
    }
}
