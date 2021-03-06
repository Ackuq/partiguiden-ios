//
//  VoteView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import SwiftUI

struct VotePropositionView: View {
    var proposition: String
    @Binding var showDocuments: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Utskottets förslag")
                .font(.headline)
            Text(proposition.replacingOccurrences(of: "\n", with: "").trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.body)
                .padding(.bottom, 5)
            
            Button("Behandlade dokument", action: { showDocuments.toggle() })
            Divider()
        }
    }
}

struct VoteDescriptionView: View {
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Beslut i korthet")
                .font(.headline)
            
            Text(parseHTML(html: description))
            Divider()
        }
    }
}

struct ProcessedDocumentsView: View {
    @State var selectedDocument: ProcessedDocumentResponse? = nil
    var documents: [EnumeratedSequence<[ProcessedDocumentResponse]>.Element]
    
    init(documents: [ProcessedDocumentResponse]) {
        self.documents = documents.enumerated().map({ $0 })
    }
    
    var body: some View {
        List(documents, id: \.element.id) { index, document in
            Button("\(index) \(document.label)", action: { selectedDocument = document })
        }.sheet(item: $selectedDocument) { document in
            SheetView {
                DocumentView(documentId: document.id)
            }
        }
    }
}

struct AppendixView: View {
    var appendix: [AppendixItemResponse]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Bilagor")
                .font(.headline)
            ForEach(appendix) { document in
                Link("\(document.titel) \(document.id)", destination: URL(string: document.fil_url)!)
            }
        }
    }
}

struct VoteDecisionView: View {
    var decision: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Beslut")
                .font(.headline)
            Text(decision)
            Divider()
        }
    }
}

struct VoteTitleView: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            Divider()
        }
    }
}

struct VoteView: View {
    var id: String
    var proposition: Int
    
    @ObservedObject var viewModel: APIViewModel<VoteResponse>
    @State var showDocuments: Bool = false
    
    init(id: String, proposition: Int) {
        self.id = id
        self.proposition = proposition
        self.viewModel = APIViewModel(
            loader: APIManager.getVote(endpoint: EndpointCases.getVote(voteId: id, propositions: proposition))
        )
    }
    
    var body: some View {
        PopableView {
            AsyncContentView(source: viewModel) { vote in
                ScrollView {
                    VStack() {
                        VoteSummaryChartView(votes: vote.voting.total)
                        VStack(alignment: .leading){
                            VoteTitleView(title: vote.title)
                            VotePropositionView(proposition: vote.propositionText, showDocuments: $showDocuments)
                            VoteDecisionView(decision: vote.decision)
                            VoteDescriptionView(description: vote.description)
                            Text("Hur partierna röstade")
                                .font(.headline)
                                .padding([.bottom])
                            VStack {
                            VoteDetailChartView(voting: vote.voting)}
                            Divider()
                            AppendixView(appendix: vote.appendix)
                        }
                        .padding()
                    }
                    
                }
                .sheet(isPresented: $showDocuments) {
                    SheetView {
                        ProcessedDocumentsView(documents: vote.processedDocuments)
                            .navigationTitle("Behandlade dokument")
                        
                    }
                }
            }
            .navigationTitle("Votering")
        }
    }
}

struct VoteView_Previews: PreviewProvider {
    static var tabBarState = TabBarState()
    
    static var previews: some View {
        NavigationView {
            VoteView(id: "H901UU11", proposition: 9)
        }
        .preferredColorScheme(.light)
        .environmentObject(tabBarState)
    }
}
