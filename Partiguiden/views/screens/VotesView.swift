//
//  VotesView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import Combine
import SwiftUI

struct VoteResultListView: View {
    var title: String
    var color: Color
    var parties: [PartyKey]

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(color.opacity(0.75))
                .if(colorScheme == .dark) { $0.opacity(0.5) }
                .frame(maxWidth: .infinity)
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                HStack {
                    Spacer()
                    ForEach(parties, id: \.self) { partyKey in
                        let partyInfo = PartyManager.parties[partyKey]!
                        partyInfo.image
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    Spacer()
                }
                .padding(.bottom)
            }
        }
    }
}

struct VoteCardView: View {
    var vote: VoteListEntry

    @State var isActive = false

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let authorityInfo = AuthorityManager.authorities[vote.authority]

        ZStack {
            NavigationLink(destination: VoteView(id: vote.documentId, proposition: vote.proposition), isActive: $isActive) {}.hidden()

            Button(action: { isActive.toggle() }) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        if authorityInfo != nil {
                            HStack {
                                Text(authorityInfo!.description)
                                    .font(.subheadline)
                                    .bold()
                                    .padding()
                                Spacer()
                            }
                            .background(
                                authorityInfo!.color
                                    .if(colorScheme == .dark) { $0.opacity(0.5) }
                            )
                            .foregroundColor(.white)
                        }
                        HStack {
                            Text(vote.title)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                        }.padding(.horizontal)
                        HStack {
                            Text(vote.subtitle)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        }.padding(.horizontal)
                    }

                    VStack(spacing: 0) {
                        VoteResultListView(title: "Ja", color: vote.results.winner == Winner
                            .yes ? .green : .gray, parties: vote.results.yes)
                        VoteResultListView(title: "Nej", color: vote.results.winner == Winner
                            .no ? .red : .gray, parties: vote.results.no)
                    }
                }
            }
            .buttonStyle(CardButtonStyle(backgroundColor: .bar, foregroundColor: .primary, usePadding: false, useSpacer: false))
            .padding(.top, 10)
        }
    }
}

struct VotesView: View {
    func createViewModel(page: Int, org: [AuthorityKey], search: String) -> APIViewModel<VoteListResponse> {
        return APIViewModel(
            loader: APIManager.getVotes(
                endpoint: endpoint(page: page, org: org, search: search)
            )
        )
    }

    func appendContent(prev: VoteListResponse, new: VoteListResponse) -> VoteListResponse {
        return VoteListResponse(pages: new.pages, votes: prev.votes + new.votes)
    }

    func endpoint(page: Int, org: [AuthorityKey], search: String) -> EndpointCases {
        return EndpointCases.getVotes(search: search, org: org.map { $0.rawValue }.joined(separator: ","), page: page)
    }

    func reload(viewModel: APIViewModel<VoteListResponse>, page: Int, org: [AuthorityKey], search: String) {
        viewModel.loader = APIManager.getVotes(
            endpoint: endpoint(page: page, org: org, search: search)
        )
        viewModel.load()
    }

    func newContentLoader(endpoint: EndpointCases) -> ((@escaping (Result<VoteListResponse, Error>) -> Void) -> AnyCancellable) {
        return APIManager.getVotes(endpoint: endpoint)
    }

    var body: some View {
        ParliamentFilterView(
            page: 1,
            org: [],
            search: "",
            title: "Voteringar",
            createViewModel: createViewModel,
            appendContent: appendContent,
            endpoint: endpoint,
            reload: reload,
            newContentLoader: newContentLoader
        ) { votesResponse in
            ForEach(votesResponse.votes) { vote in
                VoteCardView(vote: vote)
            }
            .listRowSeparator(.hidden)
        }
    }
}

struct VotesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VotesView()
            VotesView()
                .preferredColorScheme(.dark)
        }
    }
}
