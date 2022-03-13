//
//  Party.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

struct PartyData: Decodable {
    let website: String
    let leaders: [Leader]
    let ideology: [String]
    let name: String
    let abstract: String
}
