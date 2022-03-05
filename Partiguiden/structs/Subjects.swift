//
//  Subjects.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

struct SubjectListEntry: Decodable, Identifiable {
    var id: Int
    var name: String
    var related_subjects: [Int]
}

struct Standpoint: Decodable, Identifiable {
    var id: String
    var title: String
    var content: [String]
    var date: String
    var link: String
    var party: String
    var subject: Int
}

struct Subject: Decodable, Identifiable {
    var id: Int
    var name: String
    var related_subjects: [SubjectListEntry]
    var standpoints: [Standpoint]
}
