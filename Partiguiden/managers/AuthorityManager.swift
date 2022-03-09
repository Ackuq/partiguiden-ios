//
//  AuthorityManager.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import SwiftUI

struct Authority: Identifiable {
    let name: String
    let description: String
    let color: Color
    let id = UUID()
}

let authorities: [String: Authority] = [
    "AU": Authority(
        name: "Arbetsmarknadsutskottet",
        description: "Arbetsmarknad och arbetsliv",
        color: Color(red: 0.20, green: 0.60, blue: 0.86)
    ),
    "CU": Authority(
        name: "Civilutskottet",
        description: "Bostad- och konsumentpolitik",
        color: Color(red: 0.95, green: 0.61, blue: 0.07)
    ),
    "FIU": Authority(
        name: "Finansutskottet",
        description: "Ekonomi och finans",
        color: Color(red: 0.10, green: 0.74, blue: 0.61)
    ),
    "FÖU": Authority(
        name: "Försvarsutskottet",
        description: "Försvar och militär",
        color: Color(red: 0.16, green: 0.50, blue: 0.73)
    ),
    "JUU": Authority(
        name: "Justitieutskottet",
        description: "Rättsväsende och kriminalitet",
        color: Color(red: 0.20, green: 0.29, blue: 0.37)
    ),
    "KU": Authority(
        name: "Konstitutionsutskottet",
        description: "Riksdagen",
        color: Color(red: 0.83, green: 0.33, blue: 0.00)
    ),
    "KRU": Authority(
        name: "Kulturutskottet",
        description: "Kultur och folkbildning",
        color: Color(red: 0.56, green: 0.27, blue: 0.68)
    ),
    "MJU": Authority(
        name: "Miljö- och jordbruksutskottet",
        description: "Miljö och jordbruk",
        color: Color(red: 0.15, green: 0.68, blue: 0.38)
    ),
    "NU": Authority(
        name: "Näringsutskottet",
        description: "Näringsliv och energi",
        color: Color(red: 0.95, green: 0.77, blue: 0.06)
    ),
    "SKU": Authority(
        name: "Skatteutskottet",
        description: "Skatter",
        color: Color(red: 0.34, green: 0.37, blue: 0.81)
    ),
    "SFU": Authority(
        name: "Socialutskottet",
        description: "Vård och omsorg",
        color: Color(red: 1.00, green: 0.37, blue: 0.34)
    ),
    "TU": Authority(
        name: "Trafikutskottet",
        description: "Trafik och transport",
        color: Color(red: 0.24, green: 0.25, blue: 0.78)
    ),
    "UBU": Authority(
        name: "Utbildningsutskottet",
        description: "Utbildning",
        color: Color(red: 0.50, green: 0.56, blue: 0.61)
    ),
    "UU": Authority(
        name: "Utrikesutskottet",
        description: "Utrikes",
        color: Color(red: 0.96, green: 0.23, blue: 0.34)
    ),
    "UFÖU": Authority(
        name: "Sammansatta utrikes- och försvarsutskottet",
        description: "Utrikesförsvar",
        color: Color(red: 1.00, green: 0.66, blue: 0.00)
    ),
]
