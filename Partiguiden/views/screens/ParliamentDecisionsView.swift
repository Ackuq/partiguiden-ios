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
    @Environment(\.colorScheme) var colorScheme

    var decision: Decision

    var body: some View {
        let authorityInfo = authorities[decision.authority.uppercased()]
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
            SheetView(title: "Besult i korthet", showingSheet: $showingSheet) {
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
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ParliamentDecisionsView: View {
    @State var page: Int
    @State var org: [String]
    @State var search: String
    @State var filterView: Bool

    @ObservedObject var viewModel: APIViewModel<DecisionsResponse>

    init(page: Int = 1, org: [String] = [], search: String = "") {
        self.search = search
        self.org = org
        self.page = page
        filterView = false
        viewModel = APIViewModel(
            loader: ApiManager.shared.getDecisions(
                endpoint: endpoint(page: page, org: org.joined(separator: ","), search: search)
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
                                        newContentLoader: ApiManager.shared.getDecisions(endpoint: endpoint(page: page, org: org.joined(separator: ","), search: search)),
                                        appendContent: appendContent
                                    )
                                })
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.load()
                }
            }
            .navigationBarItems(trailing: Button {
                filterView.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.blue)
                    .font(.title3)
            })
            .navigationTitle("Riksdagsbeslut")
            .sheet(isPresented: $filterView) {
                SheetView(title: "Filter", showingSheet: $filterView) {
                    List {
                        Section {
                            let allBinding = Binding<Bool>(
                                get: { org.isEmpty },
                                set: {
                                    if $0 == true {
                                        org = []
                                    }
                                }
                            )
                            Toggle("Alla", isOn: allBinding)
                        }

                        ForEach(authorities.keys.sorted(), id: \.self) { authorityKey in
                            let authority = authorities[authorityKey]!
                            let activeBinding = Binding<Bool>(
                                get: { org.contains(authorityKey) },
                                set: {
                                    if $0 == false {
                                        org = org.filter { k in k != authorityKey }
                                    } else {
                                        org.append(authorityKey)
                                    }
                                }
                            )
                            Toggle(authority.description, isOn: activeBinding)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: search) { searchText in
            page = 1
            viewModel.loader = ApiManager.shared.getDecisions(
                endpoint: endpoint(page: page, org: org.joined(separator: ","), search: searchText)
            )
            viewModel.load()
        }
        .onChange(of: org, perform: { orgs in
            page = 1
            viewModel.loader = ApiManager.shared.getDecisions(
                endpoint: endpoint(page: page, org: orgs.joined(separator: ","), search: search)
            )
            viewModel.load()
        })
    }
}

struct ParliamentDecisionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParliamentDecisionsView()
            ParliamentDecisionsView()
                .preferredColorScheme(.dark)
        }
    }
}
