//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import Foundation

struct Decision: Identifiable, Decodable {
    let id: String
    let paragraph: String
    let paragraphTitle: String
    let authority: AuthorityKey
    let denomination: String
    let title: String
    let voteSearchTerm: String
    let votesExists: Bool
}

struct DecisionsResponse: Decodable, Paginated {
    let pages: Int
    let decisions: [Decision]
}
