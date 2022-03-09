//
//  PartiesView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct PartiesView: View {
    @State var activeParty: String? = nil

    @Binding var showingDetailed: Bool

    var body: some View {
        NavigationView {
            List(parties, id: \.letter) { party in
                let activeBinding = Binding<Bool>(
                    get: { showingDetailed && activeParty == party.letter },
                    set: {
                        if $0 == false {
                            showingDetailed = false
                            activeParty = nil
                        } else {
                            showingDetailed = true
                            activeParty = party.letter
                        }
                    }
                )
                NavigationLink(destination: PartyView(partyInfo: party), isActive: activeBinding) {
                    HStack {
                        party.image.resizable().frame(width: 40, height: 40)
                        Text(party.name)
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
        PartiesView(showingDetailed: .constant(true))
    }
}
