//
//  Subjects.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

struct SubjectListEntryResponse: Decodable, Identifiable {
    let id: Int
    let name: String
    let related_subjects: [Int]
}

struct StandpointResponse: Decodable, Identifiable {
    let id: String
    let title: String
    let content: [String]
    let date: String
    let link: String
    let party: Party
    let subject: Int
}

struct SubjectResponse: Decodable, Identifiable {
    let id: Int
    let name: String
    let related_subjects: [SubjectListEntryResponse]
    let standpoints: [StandpointResponse]
}
