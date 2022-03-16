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
            List(Party.allCases.sorted()) { party in
                let partyData = party.data

                NavigationLink(destination: PartyView(partyData: partyData)) {
                    HStack {
                        partyData.image.resizable().frame(width: 40, height: 40)
                        Text(partyData.name)
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
