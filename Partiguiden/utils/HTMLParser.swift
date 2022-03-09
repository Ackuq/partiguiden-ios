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
        .replacingOccurrences(of: "<li>", with: "- ")
        .replacingOccurrences(of: "</li>", with: "")
        .replacingOccurrences(of: "<ul>", with: "")
        .replacingOccurrences(of: "</ul>", with: "")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    return markdown
}
