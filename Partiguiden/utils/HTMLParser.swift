//
//  HTMLParser.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-07.
//

import Foundation

func parseHTML(html: String) -> String {
    let markdown = html
        .replacingOccurrences(of: "<b>", with: "**")
        .replacingOccurrences(of: "</b>", with: "**")
        .replacingOccurrences(of: "<p>", with: "")
        .replacingOccurrences(of: "</p>", with: "")
        .replacingOccurrences(of: "<i>", with: "*")
        .replacingOccurrences(of: "</i>", with: "*")
    return markdown
}
