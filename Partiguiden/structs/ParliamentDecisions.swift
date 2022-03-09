//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import Foundation

struct Decision: Identifiable, Decodable {
    var id: String
    var paragraph: String
    var paragraphTitle: String
    var authority: String
    var denomination: String
    var title: String
    var voteSearchTerm: String
    var votesExists: Bool
}

struct DecisionsResponse: Decodable {
    var pages: Int
    var decisions: [Decision]
}
