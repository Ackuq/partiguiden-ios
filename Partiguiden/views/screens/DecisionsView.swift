//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import Combine
import SwiftUI

struct DecisionDetailView: View {
    var decision: DecisionResponse
    @State var showDocument: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Divider()
                VStack(alignment: .leading) {
                    Text(decision.title)
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 1)
                    Text(decision.title)
                        .font(.subheadline)
                    Divider()
                    Text(parseHTML(html: decision.paragraph))
                    Divider()
                    Button("Läs mer om betänkandet", action: {
                        showDocument.toggle()
                    })
                    .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showDocument) {
                SheetView {
                    DocumentView(documentId: decision.id)
                }
            }
        }
    }
}

struct DecisionCardView: View {
    var decision: DecisionResponse
    var onPress: (DecisionResponse) -> Void

    var body: some View {
        let authorityData = decision.authority.data

        Button(action: { onPress(decision) }) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(authorityData.description)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .bold()
                    }
                    HStack {
                        Text(decision.paragraphTitle)
                            .font(.headline)
                    }
                    HStack {
                        Text(decision.title)
                            .font(.body)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .buttonStyle(CardButtonStyle(backgroundColor: authorityData.color))
    }
}

struct DecisionsView: View {
    func createViewModel(page: Int, org: Set<Authority>, search: String) -> APIViewModel<DecisionsResponse> {
        return APIViewModel(
            loader: APIManager.getDecisions(
                endpoint: endpoint(page: page, org: org, search: search)
            )
        )
    }

    func appendContent(prev: DecisionsResponse, new: DecisionsResponse) -> DecisionsResponse {
        return DecisionsResponse(pages: new.pages, decisions: prev.decisions + new.decisions)
    }

    func endpoint(page: Int, org: Set<Authority>, search: String) -> EndpointCases {

        return EndpointCases.getDecisions(search: search, org: org.map { $0.rawValue }.joined(separator: ","), page: page)
    }

    func reload(viewModel: APIViewModel<DecisionsResponse>, page: Int, org: Set<Authority>, search: String) {
        viewModel.loader = APIManager.getDecisions(
            endpoint: endpoint(page: page, org: org, search: search)
        )
        viewModel.load()
    }

    func newContentLoader(endpoint: EndpointCases) -> ((@escaping (Result<DecisionsResponse, Error>) -> Void) -> AnyCancellable) {
        return APIManager.getDecisions(endpoint: endpoint)
    }

    @State var selectedDecision: DecisionResponse? = nil

    var body: some View {
        ParliamentFilterView(
            page: 1,
            org: [],
            search: "",
            title: "Riksdagsbeslut",
            createViewModel: createViewModel,
            appendContent: appendContent,
            endpoint: endpoint,
            reload: reload,
            newContentLoader: newContentLoader

        ) { decisions in
            VStack {
                ForEach(decisions.decisions) { decision in
                    DecisionCardView(decision: decision, onPress: { selectedDecision = $0 })
                }
                .listRowSeparator(.hidden)
            }.sheet(item: $selectedDecision) { decision in
                SheetView {
                    DecisionDetailView(decision: decision)
                        .navigationTitle("Besult i korthet")
                }
            }
        }
    }
}

struct ParliamentDecisionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DecisionsView()
            DecisionsView()
                .preferredColorScheme(.dark)
        }
    }
}
