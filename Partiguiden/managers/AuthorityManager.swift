//
//  AuthorityManager.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import SwiftUI

struct AuthorityData: Identifiable {
    let id: Authority
    var code: Authority { id }
    let name: String
    let description: String
    var color: Color { Color(code.rawValue) }
}

enum Authority: String, Codable, CaseIterable, Identifiable {
    case AU, CU, FiU, FöU, JuU, KU, KrU, MJU, NU, SkU, SfU, SoU, TU, UbU, UU, UFöU
    
    var id: Self { self }
    var data: AuthorityData { Authority._authorityData[self]! }
    
    private static let _authorityData: [Authority: AuthorityData] = [
        .AU: AuthorityData(
            id: .AU,
            name: "Arbetsmarknadsutskottet",
            description: "Arbetsmarknad och arbetsliv"
        ),
        .CU: AuthorityData(
            id: .CU,
            name: "Civilutskottet",
            description: "Bostad- och konsumentpolitik"
        ),
        .FiU: AuthorityData(
            id: .FiU,
            name: "Finansutskottet",
            description: "Ekonomi och finans"
        ),
        .FöU: AuthorityData(
            id: .FöU,
            name: "Försvarsutskottet",
            description: "Försvar och militär"
        ),
        .JuU: AuthorityData(
            id: .JuU,
            name: "Justitieutskottet",
            description: "Rättsväsende och kriminalitet"
        ),
        .KU: AuthorityData(
            id: .KU,
            name: "Konstitutionsutskottet",
            description: "Riksdagen"
        ),
        .KrU: AuthorityData(
            id: .KrU,
            name: "Kulturutskottet",
            description: "Kultur och folkbildning"
        ),
        .MJU: AuthorityData(
            id: .MJU,
            name: "Miljö- och jordbruksutskottet",
            description: "Miljö och jordbruk"
        ),
        .NU: AuthorityData(
            id: .NU,
            name: "Näringsutskottet",
            description: "Näringsliv och energi"
        ),
        .SkU: AuthorityData(
            id: .SkU,
            name: "Skatteutskottet",
            description: "Skatter"
        ),
        .SfU: AuthorityData(
            id: .SfU,
            name: "Socialförsäkringsutskottet",
            description: "Socialförsäkringar"
        ),
        .SoU: AuthorityData(
            id: .SoU,
            name: "Socialutskottet",
            description: "Vård och omsorg"
        ),
        .TU: AuthorityData(
            id: .TU,
            name: "Trafikutskottet",
            description: "Trafik och transport"
        ),
        .UbU: AuthorityData(
            id: .UbU,
            name: "Utbildningsutskottet",
            description: "Utbildning"
        ),
        .UU: AuthorityData(
            id: .UU,
            name: "Utrikesutskottet",
            description: "Utrikes"
        ),
        .UFöU: AuthorityData(
            id: .UFöU,
            name: "Sammansatta utrikes- och försvarsutskottet",
            description: "Utrikesförsvar"
        ),
    ]
}
