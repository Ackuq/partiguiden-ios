//
//  PartiesView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct PartiesView: View {
    var body: some View {
        NavigationView {
            List(PartyKey.allCases, id: \.self) { partyKey in
                let partyInfo = PartyManager.parties[partyKey]!

                NavigationLink(destination: PartyView(partyInfo: partyInfo)) {
                    HStack {
                        partyInfo.image.resizable().frame(width: 40, height: 40)
                        Text(partyInfo.name)
                    }
                }
            }
            .navigationTitle("Partier")
        }
        .navigationViewStyle(.stack)
    }
}

struct PartiesView_Previews: PreviewProvider {
    static var previews: some View {
        PartiesView()
    }
}
