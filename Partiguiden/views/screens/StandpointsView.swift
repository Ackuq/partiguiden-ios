//
//  StandpointsView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct PartyStandpointsListView: View {
    var standpoints: [StandpointResponse]
    var partyData: PartyData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(standpoints) { standpoint in
                    Text(standpoint.title)
                        .font(.headline)
                    ForEach(standpoint.content, id: \.self) { content in
                        HStack(alignment: .top) {
                            Rectangle().foregroundColor(partyData.color).frame(width: 10, height: 10).padding(.vertical, 7.5)
                            Text(content)
                        }
                    }
                    Link("Läs mer på partiets hemsida", destination: URL(string: standpoint.link)!)
                        .foregroundColor(partyData.color)
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
    
    @ObservedObject var viewModel: APIViewModel<SubjectResponse>
    
    @State var selectedParty: PartyData? = nil
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        viewModel = APIViewModel(loader: APIManager.getSubject(endpoint: EndpointCases.getSubject(id: id)))
    }
    
    var body: some View {
        PopableView {
            AsyncContentView(source: viewModel) { subject in
                let partyStandpoints = createStandpointsMap(standpoints: subject.standpoints)
                
                ScrollView {
                    LazyVStack {
                        ForEach(partyStandpoints.keys.sorted()) { party in
                            let partyInfo = party.data
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
                .sheet(item: $selectedParty) { partyData in
                    let standpoints = partyStandpoints[partyData.id]!
                    SheetView {
                        PartyStandpointsListView(standpoints: standpoints, partyData: partyData)
                            .navigationTitle(partyData.name)
                    }
                }
            }
        }
        .navigationTitle(name)
    }
}

struct StandpointsView_Previews: PreviewProvider {
    static var tabBarState = TabBarState()
    static var previews: some View {
        NavigationView {
            StandpointsView(id: 3, name: "Test")
        }
        .preferredColorScheme(.dark)
        .environmentObject(tabBarState)
    }
}
