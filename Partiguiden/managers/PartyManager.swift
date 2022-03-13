//
//  PartyManager.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

import SwiftUI

enum PartyKey: String, Decodable, CaseIterable, Comparable {
    static func < (lhs: PartyKey, rhs: PartyKey) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    case S, M, SD, C, V, KD, L, MP
}

struct PartyInfo: Identifiable {
    let id: PartyKey
    var letter: PartyKey { id }
    let name: String
    var color: Color { Color(id.rawValue) }
    let image: Image
}

enum PartyManager {
    static let parties: [PartyKey: PartyInfo] = [
        .S: PartyInfo(
            id: .S,
            name: "Socialdemokraterna",
            image: Image("S")
        ),
        .M: PartyInfo(
            id: .M,
            name: "Moderaterna",
            image: Image("M")
        ),
        .SD: PartyInfo(
            id: .SD,
            name: "Sverigedemokraterna",
            image: Image("SD")
        ),
        .C: PartyInfo(
            id: .C,
            name: "Centerpartiet",
            image: Image("C")
        ),
        .V: PartyInfo(
            id: .V,
            name: "Vänsterpartiet",
            image: Image("V")
        ),
        .KD: PartyInfo(
            id: .KD,
            name: "Kristdemokraterna",
            image: Image("KD")
        ),
        .L: PartyInfo(
            id: .L,
            name: "Liberalerna",
            image: Image("L")
        ),
        .MP: PartyInfo(
            id: .MP,
            name: "Miljöpartiet",
            image: Image("MP")
        ),
    ]

    static func createStandpointsMap(standpoints: [Standpoint]) -> [PartyKey: [Standpoint]] {
        return standpoints.reduce(into: [:]) { res, curr in
            var currContent = res[curr.party] ?? []
            currContent.append(curr)
            res[curr.party] = currContent
        }
    }
}
