//
//  ParliamentDecisions.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-08.
//

import SwiftUI

func appendContent(prev: DecisionsResponse, new: DecisionsResponse) -> DecisionsResponse {
    return DecisionsResponse(pages: new.pages, decisions: prev.decisions + new.decisions)
}

func endpoint(page: Int, org: String, search: String) -> EndpointCases {
    return EndpointCases.getDecisions(search: search, org: org, page: page)
}

struct DecisionCardView: View {
    @State private var showingSheet = false

    var decision: Decision

    var body: some View {
        let authorityInfo = AuthorityManager.authorities[decision.authority.uppercased()]
        Button(action: { showingSheet.toggle() }) {
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
        .buttonStyle(CardButtonStyle(backgroundColor: authorityInfo?.color ?? .accentColor))
        .sheet(isPresented: $showingSheet) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Stäng") {
                        showingSheet.toggle()
                    }
                }.padding(.bottom, 15)
                Divider()
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
                    }
                }
            }.padding()
        }
    }
}

struct ParliamentDecisionsView: View {
    @State var page: Int
    @State var org: String
    @State var search: String

    @ObservedObject var viewModel: APIViewModel<DecisionsResponse>

    init(page: Int = 1, org: String = "", search: String = "") {
        self.search = search
        self.org = org
        self.page = page
        viewModel = APIViewModel(
            loader: ApiManager.shared.getDecisions(
                endpoint: endpoint(page: page, org: org, search: search)
            )
        )
    }

    var body: some View {
        NavigationView {
            AsyncContentView(source: viewModel) { decisions in

                List {
                    ForEach(decisions.decisions) { decision in
                        DecisionCardView(decision: decision)
                    }
                    .listRowSeparator(.hidden)
                    if page < decisions.pages {
                        HStack {
                            Spacer()
                            ProgressView()
                                .padding(.vertical, 10)
                                .onAppear(perform: {
                                    page += 1
                                    viewModel.loadMoreContent(
                                        newContentLoader: ApiManager.shared.getDecisions(endpoint: endpoint(page: self.page, org: self.org, search: self.search)),
                                        appendContent: appendContent
                                    )
                                })
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Riksdagsbeslut")
                .refreshable {
                    viewModel.load()
                }
                .searchable(text: $search)
                .onChange(of: search) { searchText in
                    viewModel.loader = ApiManager.shared.getDecisions(
                        endpoint: endpoint(page: page, org: org, search: searchText)
                    )
                    viewModel.load()
                }
            }

        }.navigationViewStyle(.stack)
    }
}

struct ParliamentDecisionsView_Previews: PreviewProvider {
    static var previews: some View {
        ParliamentDecisionsView()
    }
}
