//
//  PartyManager.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

import SwiftUI

struct PartyInfo {
    var name: String
    var letter: String
    var color: Color
}

class PartyManager {
    static let parties: [PartyInfo] = [
        PartyInfo(name: "Socialdemokraterna", letter: "S", color: Color(red: 0.75, green: 0.22, blue: 0.17)),
        PartyInfo(name: "Moderaterna", letter: "M", color: Color(red: 0.23, green: 0.33, blue: 0.61)),
        PartyInfo(name: "Sverigedemokraterna", letter: "SD", color: Color(red: 0.96, green: 0.82, blue: 0.25)),
        PartyInfo(name: "Centerpartiet", letter: "C", color: Color(red: 0.12, green: 0.51, blue: 0.30)),
        PartyInfo(name: "Vänsterpartiet", letter: "V", color: Color(red: 0.81, green: 0.00, blue: 0.06)),
        PartyInfo(name: "Kristdemokraterna", letter: "KD", color: Color(red: 0.13, green: 0.65, blue: 0.94)),
        PartyInfo(name: "Liberalerna", letter: "L", color: Color(red: 0.36, green: 0.59, blue: 0.75)),
        PartyInfo(name: "Miljöpartiet", letter: "MP", color: Color(red: 0.15, green: 0.65, blue: 0.36)),
    ]
    
    static let partyLetterDict: [String:PartyInfo] = Dictionary.init(uniqueKeysWithValues: parties.map{ ($0.letter, $0) })
    
    static func createStandpointsMap(standpoints: [Standpoint]) -> [String:[Standpoint]] {
        return standpoints.reduce([:] as [String:[Standpoint]], { res, curr in 
            
        })
    }
}
