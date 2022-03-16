//
//  Standpoints.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import Foundation

func createStandpointsMap(standpoints: [StandpointResponse]) -> [Party: [StandpointResponse]] {
    return standpoints.reduce(into: [:]) { res, curr in
        var currContent = res[curr.party] ?? []
        currContent.append(curr)
        res[curr.party] = currContent
    }
}
