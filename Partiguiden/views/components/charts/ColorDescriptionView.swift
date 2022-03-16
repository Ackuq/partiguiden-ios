//
//  ColorDescriptionView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import SwiftUI

struct ColorDescriptionView: View {
    var body: some View {
        HStack {
            HStack {
                Rectangle()
                    .fill(voteColors.yes)
                    .frame(width: 10, height: 10)
                Text("Ja")
            }
            HStack {
                Rectangle()
                    .fill(voteColors.no)
                    .frame(width: 10, height: 10)
                Text("Nej")
            }
            HStack {
                Rectangle()
                    .fill(voteColors.refrain)
                    .frame(width: 10, height: 10)
                Text("Avstående")
            }
            HStack {
                Rectangle()
                    .fill(voteColors.abscent)
                    .frame(width: 10, height: 10)
                Text("Frånvarande")
            }
        }
    }
}

struct ColorDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorDescriptionView()
    }
}
