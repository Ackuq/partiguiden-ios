//
//  Member.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//

struct MemberDocumentResponse: Decodable, Identifiable {
    let id: String
    let authority: String?
    let title: String
    let subtitle: String
    let altTitle: String
}

struct MemberDocumentsResponse: Decodable {
    let pages: Int
    let count: Int
    let documents: [MemberDocumentsResponse]
}

struct InformationResponse: Decodable {
    let code: String
    let content: [String]
    let type: String
}

struct TaskResponse: Decodable {
    let authorityCode: String
    let role: String
    let content: [String]
    let status: String?
    let type: String
    let from: String
    let to: String
}

struct MemberResponse: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [InformationResponse]
    let tasks: [TaskResponse]
    let isLeader: Bool
    let absence: Int?
}

struct MemberListEntryResponse: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [InformationResponse]
    let tasks: [TaskResponse]
    let isLeader: Bool
}

struct LeaderResponse: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [InformationResponse]
    let tasks: [TaskResponse]
    let isLeader: Bool
    let role: String
}
