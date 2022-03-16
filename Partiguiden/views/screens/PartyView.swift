//
//  PartyView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-05.
//

import SwiftUI

struct PartyView: View {
    var partyInfo: PartyInfo
    
    @ObservedObject var viewModel: APIViewModel<PartyData>
    
    init(partyInfo: PartyInfo) {
        self.partyInfo = partyInfo
        viewModel = APIViewModel(loader: APIManager.getPartyData(endpoint: EndpointCases.getPartyData(abbreviation: partyInfo.id.rawValue)))
    }
    
    var body: some View {
        PopableView {
            AsyncContentView(source: viewModel) {
                partyData in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            partyInfo.image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 10)
                            VStack(alignment: .leading) {
                                Text("Hemsida")
                                Link(partyData.website, destination: URL(string: partyData.website)!)
                                    .foregroundColor(partyInfo.color)
                            }
                        }
                        Divider()
                        Section(header: Text("Ideologi").font(.headline)) {
                            Text(partyData.ideology.joined(separator: ", "))
                            HStack {
                                Text("Källa:")
                                Link("https://wikipedia.se", destination: URL(string: "https://wikipedia.se")!)
                            }
                        }
                        
                        Divider()
                        Section(header: Text("Biografi").font(.headline)) {
                            Text(parseHTML(html: partyData.abstract))
                        }
                        Spacer()
                    }
                    .padding(10)
                }
            }
            .navigationTitle(partyInfo.name)
        }
    }
}

struct PartyView_Previews: PreviewProvider {
    static var tabBarState = TabBarState()
    
    static var previews: some View {
        NavigationView {
            PartyView(partyInfo: PartyManager.parties[.S]!)
        }
        .environmentObject(tabBarState)
    }
}
