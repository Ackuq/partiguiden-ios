//
//  Votes.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import Foundation
import SwiftUI

enum Winner: String, Decodable {
    case yes, no, draw
}

struct VotingResult: Decodable {
    let yes: [PartyKey]
    let no: [PartyKey]
    let winner: Winner
}

struct VoteListEntry: Decodable, Identifiable {
    let id = UUID()

    let title: String
    let authority: AuthorityKey
    let documentId: String
    let proposition: Int
    let subtitle: String
    let results: VotingResult

    private enum CodingKeys: String, CodingKey {
        case title, authority, documentId, proposition, subtitle, results
    }
}

struct VoteListResponse: Decodable, Paginated {
    let pages: Int
    let votes: [VoteListEntry]
}

enum VoteDescription: String, Decodable {
    case yes, no, refrain, abscent
}

struct ProcessedDocument: Decodable, Identifiable {
    let id: String
    let label: String
    let proposals: String?
}

struct AppendixItem: Decodable, Identifiable {
    let titel: String
    let dok_id: String
    let fil_url: String

    var id: String { dok_id }
}

struct Vote {
    let title: String
    let description: String
    let authority: AuthorityKey
    let propositionText: String
    let processedDocuments: [ProcessedDocument]
    let appendix: [AppendixItem]
    let deicision: String
    let voting: [String: [VoteDescription: String]]
}
