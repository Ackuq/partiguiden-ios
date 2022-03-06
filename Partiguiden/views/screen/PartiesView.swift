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
            List(PartyManager.parties, id: \.letter) { party in
                NavigationLink(destination: PartyView(partyInfo: party)) {
                    HStack {
                        party.image.resizable().frame(width: 40, height: 40)
                        Text(party.name)
                    }
                }
            }
            .navigationTitle("Partier")
        }
    }
}

struct PartiesView_Previews: PreviewProvider {
    static var previews: some View {
        PartiesView()
    }
}
