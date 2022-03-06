//
//  Member.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//

struct MemberDocument: Decodable, Identifiable {
    var id: String
    var authority: String?
    var title: String
    var subtitle: String
    var altTitle: String
}

struct MemberDocuments: Decodable {
    var pages: Int
    var count: Int
    var documents: [MemberDocuments]
}

struct Information: Decodable {
    var code: String
    var content: [String]
    var type: String
}

struct Task: Decodable {
    var authorityCode: String
    var role: String
    var content: [String]
    var status: String?
    var type: String
    var from: String
    var to: String
}

struct Member: Decodable, Identifiable {
    var id: String
    var sourceId: String
    var firstName: String
    var lastName: String
    var pictureUrl: String
    var age: Int
    var party: String
    var district: String
    var status: String
    var information: [Information]
    var tasks: [Task]
    var isLeader: Bool
    var absence: Int?
}

struct MemberListEntry: Decodable, Identifiable {
    var id: String
    var sourceId: String
    var firstName: String
    var lastName: String
    var pictureUrl: String
    var age: Int
    var party: String
    var district: String
    var status: String
    var information: [Information]
    var tasks: [Task]
    var isLeader: Bool
}

struct Leader: Decodable, Identifiable {
    var id: String
    var sourceId: String
    var firstName: String
    var lastName: String
    var pictureUrl: String
    var age: Int
    var party: String
    var district: String
    var status: String
    var information: [Information]
    var tasks: [Task]
    var isLeader: Bool
    var role: String
}
