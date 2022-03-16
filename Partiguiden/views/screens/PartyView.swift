//
//  PartyView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//

import SwiftUI

struct PartyView: View {
    var partyData: PartyData
    
    @ObservedObject var viewModel: APIViewModel<PartyDataResponse>
    
    init(partyData: PartyData) {
        self.partyData = partyData
        viewModel = APIViewModel(loader: APIManager.getPartyData(endpoint: EndpointCases.getPartyData(abbreviation: partyData.id.rawValue)))
    }
    
    var body: some View {
        PopableView {
            AsyncContentView(source: viewModel) {
                partyDataResponse in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            partyData.image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 10)
                            VStack(alignment: .leading) {
                                Text("Hemsida")
                                Link(partyDataResponse.website, destination: URL(string: partyDataResponse.website)!)
                                    .foregroundColor(partyData.color)
                            }
                        }
                        Divider()
                        Section(header: Text("Ideologi").font(.headline)) {
                            Text(partyDataResponse.ideology.joined(separator: ", "))
                            HStack {
                                Text("Källa:")
                                Link("https://wikipedia.se", destination: URL(string: "https://wikipedia.se")!)
                            }
                        }
                        
                        Divider()
                        Section(header: Text("Biografi").font(.headline)) {
                            Text(parseHTML(html: partyDataResponse.abstract))
                        }
                        Spacer()
                    }
                    .padding(10)
                }
            }
            .navigationTitle(partyData.name)
        }
    }
}

struct PartyView_Previews: PreviewProvider {
    static var tabBarState = TabBarState()
    
    static var previews: some View {
        NavigationView {
            PartyView(partyData: Party.S.data)
        }
        .environmentObject(tabBarState)
    }
}
