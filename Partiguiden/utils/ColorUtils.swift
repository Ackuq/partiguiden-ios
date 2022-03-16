//
//  ColorUtils.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import Foundation
import SwiftUI


struct VoteColor {
    var yes: Color = .green.opacity(0.75)
    var no: Color = .red.opacity(0.75)
    var refrain: Color = Color(uiColor: .systemGray4)
    var abscent: Color = Color(uiColor: .systemGray)
}

var voteColorsLight = VoteColor()

var voteColorsDark = VoteColor(yes: .green.opacity(0.5), no: .red.opacity(0.5))
