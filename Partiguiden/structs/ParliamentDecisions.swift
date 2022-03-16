//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import Foundation

struct DecisionResponse: Identifiable, Decodable {
    let id: String
    let paragraph: String
    let paragraphTitle: String
    let authority: Authority
    let denomination: String
    let title: String
    let voteSearchTerm: String
    let votesExists: Bool
}

struct DecisionsResponse: Decodable, PaginatedResponse {
    let pages: Int
    let decisions: [DecisionResponse]
}
