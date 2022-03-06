//
//  Party.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

struct PartyData: Decodable {
    var website: String
    var leaders: [Leader]
    var ideology: [String]
    var name: String
    var abstract: String
}
