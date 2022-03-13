//
//  Member.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//

struct MemberDocument: Decodable, Identifiable {
    let id: String
    let authority: String?
    let title: String
    let subtitle: String
    let altTitle: String
}

struct MemberDocuments: Decodable {
    let pages: Int
    let count: Int
    let documents: [MemberDocuments]
}

struct Information: Decodable {
    let code: String
    let content: [String]
    let type: String
}

struct Task: Decodable {
    let authorityCode: String
    let role: String
    let content: [String]
    let status: String?
    let type: String
    let from: String
    let to: String
}

struct Member: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [Information]
    let tasks: [Task]
    let isLeader: Bool
    let absence: Int?
}

struct MemberListEntry: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [Information]
    let tasks: [Task]
    let isLeader: Bool
}

struct Leader: Decodable, Identifiable {
    let id: String
    let sourceId: String
    let firstName: String
    let lastName: String
    let pictureUrl: String
    let age: Int
    let party: String
    let district: String
    let status: String
    let information: [Information]
    let tasks: [Task]
    let isLeader: Bool
    let role: String
}
