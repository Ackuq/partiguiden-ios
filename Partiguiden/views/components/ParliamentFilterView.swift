//
//  ParliamentFilterView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import Combine
import SwiftUI

struct ParliamentFilterView<ResponseType: Paginated, Content>: View where Content: View {
    @State var page: Int
    @State var org: [AuthorityKey]
    @State var search: String
    @State var filterView: Bool

    var title: String

    @ObservedObject var viewModel: APIViewModel<ResponseType>

    var createViewModel: (_ page: Int, _ org: [AuthorityKey], _ search: String) -> APIViewModel<ResponseType>

    var appendContent: (_ prev: ResponseType, _ new: ResponseType) -> ResponseType

    var endpoint: (_ page: Int, _ org: [AuthorityKey], _ search: String) -> EndpointCases

    var reload: (_ viewModel: APIViewModel<ResponseType>, _ page: Int, _ org: [AuthorityKey], _ search: String) -> Void

    var newContentLoader: (_ endpoint: EndpointCases) -> (@escaping (Result<ResponseType, Error>) -> Void) -> AnyCancellable

    @ViewBuilder var content: (_ response: ResponseType) -> Content

    init(
        page: Int = 1,
        org: [AuthorityKey] = [],
        search: String = "",
        title: String,
        createViewModel: @escaping (_ page: Int, _ org: [AuthorityKey], _ search: String) -> APIViewModel<ResponseType>,
        appendContent: @escaping (_ prev: ResponseType, _ new: ResponseType) -> ResponseType,
        endpoint: @escaping (_ page: Int, _ org: [AuthorityKey], _ search: String) -> EndpointCases,
        reload: @escaping (_ viewModel: APIViewModel<ResponseType>, _ page: Int, _ org: [AuthorityKey], _ search: String) -> Void,
        newContentLoader: @escaping (_ endpoint: EndpointCases) -> ((@escaping (Result<ResponseType, Error>) -> Void) -> AnyCancellable),
        content: @escaping (_ response: ResponseType) -> Content
    ) {
        self.search = search
        self.org = org
        self.page = page

        self.title = title

        filterView = false

        self.createViewModel = createViewModel
        self.appendContent = appendContent
        self.endpoint = endpoint
        self.reload = reload
        self.newContentLoader = newContentLoader
        self.content = content
        viewModel = createViewModel(page, org, search)
    }

    var body: some View {
        NavigationView {
            AsyncContentView(source: viewModel) { value in
                List {
                    content(value)
                    if page < value.pages {
                        HStack {
                            Spacer()
                            ProgressView()
                                .padding(.vertical, 10)
                                .onAppear(perform: {
                                    page += 1
                                    viewModel.loadMoreContent(
                                        newContentLoader: newContentLoader(endpoint(page, org, search)),
                                        appendContent: appendContent
                                    )
                                })
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.load(updateState: false)
                }
            }
            .navigationBarItems(trailing: Button {
                filterView.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(Color("AccentColor"))
                    .font(.title3)
            })
            .navigationTitle(title)
            .sheet(isPresented: $filterView) {
                SheetView(title: "Filter") {
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
                                .disabled(allBinding.wrappedValue)
                        }

                        ForEach(AuthorityKey.allCases, id: \.self) { authorityKey in
                            let authority = AuthorityManager.authorities[authorityKey]!
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
        .onChange(of: search) { _ in
            page = 1
            reload(viewModel, page, org, search)
        }
        .onChange(of: org, perform: { _ in
            page = 1
            reload(viewModel, page, org, search)
        })
    }
}
