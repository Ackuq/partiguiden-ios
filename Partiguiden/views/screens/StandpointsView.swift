//
//  StandpointsView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct PartyStandpointsListView: View {
    var standpoints: [Standpoint]
    var partyInfo: PartyInfo

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(standpoints) { standpoint in
                    Text(standpoint.title)
                        .font(.headline)
                    ForEach(standpoint.content, id: \.self) { content in
                        HStack(alignment: .top) {
                            Rectangle().foregroundColor(partyInfo.color).frame(width: 10, height: 10).padding(.vertical, 7.5)
                            Text(content)
                        }
                    }
                    Link("Läs mer på partiets hemsida", destination: URL(string: standpoint.link)!)
                        .foregroundColor(partyInfo.color)
                    if standpoint.id != standpoints.last?.id {
                        Divider()
                    }
                }
            }.padding()
        }
    }
}

struct StandpointsView: View {
    var id: Int
    var name: String

    @ObservedObject var viewModel: APIViewModel<Subject>

    @State var selectedParty: PartyInfo? = nil

    init(id: Int, name: String) {
        self.id = id
        self.name = name
        viewModel = APIViewModel(loader: APIManager.getSubject(endpoint: EndpointCases.getSubject(id: id)))
    }

    var body: some View {
        AsyncContentView(source: viewModel) { subject in
            let partyStandpoints = PartyManager.createStandpointsMap(standpoints: subject.standpoints)
            ScrollView {
                LazyVStack {
                    ForEach(partyStandpoints.keys.sorted(), id: \.rawValue) { party in
                        let partyInfo = PartyManager.parties[party]!
                        Button(action: { self.selectedParty = partyInfo }) {
                            Text(partyInfo.name)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(partyInfo.color)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(item: $selectedParty) { partyInfo in
                let standpoints = partyStandpoints[partyInfo.id]!
                SheetView(title: partyInfo.name) {
                    PartyStandpointsListView(standpoints: standpoints, partyInfo: partyInfo)
                }
            }
        }
        .navigationTitle(self.name)
    }
}

struct StandpointsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StandpointsView(id: 3, name: "Test")
        }
    }
}
