//
//  Votes.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import Foundation
import SwiftUI

enum WinnerResponse: String, Decodable {
    case yes, no, draw
}

struct VotingResultResponse: Decodable {
    let yes: [Party]
    let no: [Party]
    let winner: WinnerResponse
}

struct VoteListEntryResponse: Decodable, Identifiable {
    let id = UUID()
    
    let title: String
    let authority: Authority
    let documentId: String
    let proposition: Int
    let subtitle: String
    let results: VotingResultResponse
    
    private enum CodingKeys: String, CodingKey {
        case title, authority, documentId, proposition, subtitle, results
    }
}

struct VoteListResponse: Decodable, PaginatedResponse {
    let pages: Int
    let votes: [VoteListEntryResponse]
}

struct VoteDescriptionResponse: Decodable {
    var yes: String
    var no: String
    var refrain: String
    var abscent: String
}

struct ProcessedDocumentResponse: Decodable, Identifiable {
    let id: String
    let label: String
    let proposals: String?
}

struct AppendixItemResponse: Decodable, Identifiable {
    let titel: String
    let dok_id: String
    let fil_url: String
    
    var id: String { dok_id }
}

struct VotingParticipantsResponse: Decodable {
    let total: VoteDescriptionResponse
    let noParty: VoteDescriptionResponse
    let S: VoteDescriptionResponse
    let M: VoteDescriptionResponse
    let SD: VoteDescriptionResponse
    let C: VoteDescriptionResponse
    let V: VoteDescriptionResponse
    let KD: VoteDescriptionResponse
    let L: VoteDescriptionResponse
    let MP: VoteDescriptionResponse
}

struct VoteResponse: Decodable {
    let title: String
    let description: String
    let authority: Authority
    let propositionText: String
    let processedDocuments: [ProcessedDocumentResponse]
    let appendix: [AppendixItemResponse]
    let decision: String
    let voting: VotingParticipantsResponse
}
