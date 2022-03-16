//
//  ColorUtils.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import Foundation
import SwiftUI


struct VoteColors {
    var yes: Color
    var no: Color
    var refrain: Color
    var abscent: Color
}

var voteColors = VoteColors(yes: Color("YesVote"), no: Color("NoVote"), refrain: Color("RefrainVote"), abscent: Color("AbscentVote"))
