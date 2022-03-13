//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import Combine
import SwiftUI

struct DecisionDetailView: View {
    var decision: Decision

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
                    NavigationLink(destination: DocumentView(documentId: decision.id)) {
                        Text("Läs mer om betänkandet")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct DecisionCardView: View {
    @Environment(\.colorScheme) var colorScheme
    var decision: Decision
    var onPress: (Decision) -> Void

    var body: some View {
        let authorityInfo = AuthorityManager.authorities[decision.authority]
        let backgroundColor = colorScheme == .dark ? authorityInfo?.color.opacity(0.5) : authorityInfo?.color

        Button(action: { onPress(decision) }) {
            VStack(alignment: .leading, spacing: 10) {
                if authorityInfo != nil {
                    HStack {
                        Text(authorityInfo!.description)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                HStack {
                    Text(decision.paragraphTitle)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
                HStack {
                    Text(decision.title)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .buttonStyle(CardButtonStyle(backgroundColor: backgroundColor ?? .accentColor))
    }
}

struct DecisionsView: View {
    func createViewModel(page: Int, org: [AuthorityKey], search: String) -> APIViewModel<DecisionsResponse> {
        return APIViewModel(
            loader: APIManager.getDecisions(
                endpoint: endpoint(page: page, org: org, search: search)
            )
        )
    }

    func appendContent(prev: DecisionsResponse, new: DecisionsResponse) -> DecisionsResponse {
        return DecisionsResponse(pages: new.pages, decisions: prev.decisions + new.decisions)
    }

    func endpoint(page: Int, org: [AuthorityKey], search: String) -> EndpointCases {
        return EndpointCases.getDecisions(search: search, org: org.map { $0.rawValue }.joined(separator: ","), page: page)
    }

    func reload(viewModel: APIViewModel<DecisionsResponse>, page: Int, org: [AuthorityKey], search: String) {
        viewModel.loader = APIManager.getDecisions(
            endpoint: endpoint(page: page, org: org, search: search)
        )
        viewModel.load()
    }

    func newContentLoader(endpoint: EndpointCases) -> ((@escaping (Result<DecisionsResponse, Error>) -> Void) -> AnyCancellable) {
        return APIManager.getDecisions(endpoint: endpoint)
    }

    @State var selectedDecision: Decision? = nil

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
                SheetView(title: "Besult i korthet") {
                    DecisionDetailView(decision: decision)
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
