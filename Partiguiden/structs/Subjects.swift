//
//  Subjects.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

struct SubjectListEntry: Decodable, Identifiable {
    let id: Int
    let name: String
    let related_subjects: [Int]
}

struct Standpoint: Decodable, Identifiable {
    let id: String
    let title: String
    let content: [String]
    let date: String
    let link: String
    let party: PartyKey
    let subject: Int
}

struct Subject: Decodable, Identifiable {
    let id: Int
    let name: String
    let related_subjects: [SubjectListEntry]
    let standpoints: [Standpoint]
}
