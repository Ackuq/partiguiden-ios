//
//  StandpointsView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct StandpointsView: View {
    var id: Int
    var name: String
    @ObservedObject var viewModel: APIViewModel<Subject>

    init(id: Int, name: String) {
        self.id = id
        self.name = name
        viewModel = APIViewModel(loader: ApiManager.shared.getSubject(endpoint: EndpointCases.getSubject(id: id)))
    }

    var body: some View {
        AsyncContentView(source: viewModel) { subject in
            let partyStandpoints = PartyManager.createStandpointsMap(standpoints: subject.standpoints)
            ScrollView {
                ForEach(partyStandpoints.keys.sorted(), id: \.self) { party in
                    PartyStandpointView(party: party, standpoints: partyStandpoints[party]!)
                }
            }
        }
        .navigationTitle(self.name)
    }
}

struct StandpointsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StandpointsView(id: 2, name: "Test")
        }
    }
}
