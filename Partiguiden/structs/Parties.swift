//
//  Party.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

struct PartyDataResponse: Decodable {
    let website: String
    let leaders: [LeaderResponse]
    let ideology: [String]
    let name: String
    let abstract: String
}
