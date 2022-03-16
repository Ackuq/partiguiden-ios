//
//  PartyManager.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

import SwiftUI

struct PartyData: Identifiable {
    let id: Party
    var letter: Party { id }
    let name: String
    var color: Color { Color(id.rawValue) }
    let image: Image
}

enum Party: String, Decodable, CaseIterable, Comparable, Identifiable {
    case S, M, SD, C, V, KD, L, MP
    
    var id: Self { self }
    var data: PartyData { Party._partyData[self]! }
    
    private var _sortOrder: Int {
        switch self {
        case .S:
            return 0
        case .M:
            return 1
        case .SD:
            return 2
        case .C:
            return 3
        case .V:
            return 4
        case .KD:
            return 5
        case .L:
            return 6
        case .MP:
            return 7
        }
    }
    
    static func ==(lhs: Party, rhs: Party) -> Bool {
           return lhs._sortOrder == rhs._sortOrder
       }

    static func <(lhs: Party, rhs: Party) -> Bool {
        return lhs._sortOrder < rhs._sortOrder
    }
    
    private static let _partyData: [Party: PartyData] = [
        .S: PartyData(
            id: .S,
            name: "Socialdemokraterna",
            image: Image("S")
        ),
        .M: PartyData(
            id: .M,
            name: "Moderaterna",
            image: Image("M")
        ),
        .SD: PartyData(
            id: .SD,
            name: "Sverigedemokraterna",
            image: Image("SD")
        ),
        .C: PartyData(
            id: .C,
            name: "Centerpartiet",
            image: Image("C")
        ),
        .V: PartyData(
            id: .V,
            name: "Vänsterpartiet",
            image: Image("V")
        ),
        .KD: PartyData(
            id: .KD,
            name: "Kristdemokraterna",
            image: Image("KD")
        ),
        .L: PartyData(
            id: .L,
            name: "Liberalerna",
            image: Image("L")
        ),
        .MP: PartyData(
            id: .MP,
            name: "Miljöpartiet",
            image: Image("MP")
        ),
    ]
}
