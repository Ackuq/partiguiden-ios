//
//  DocumentView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-11.
//

import SwiftUI

let styleString: String = """
<style>
    :root {
        font-family: -apple-system;
        color-scheme: light dark;
        --link-color: rgb(0, 121, 107);
        --text-color: black;
        padding-left: 10;
        padding-right: 10;
    }
    @media screen and (prefers-color-scheme: dark) {
        :root {
            --link-color: rgb(0, 121, 107);
            --text-color: white;
        }
    }
    body * {
        color: var(--text-color) !important;
        border-color: var(--text-color) !important;
        max-width: 100%;
    }

    span.Hyperlink {
        color: var(--link-color) !important;
    }
    span {
        color: var(--text-color) !important;
    }
    footer {
        font: -apple-system-footnote;
    }
</style>
"""

struct DocumentView: View {
    var documentId: String

    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"

    @ObservedObject var viewModel: APIViewModel<DocumentResponse>
    init(documentId: String) {
        self.documentId = documentId

        viewModel = APIViewModel(
            loader: APIManager.getDocument(endpoint: EndpointCases.getDocument(id: documentId))
        )
    }

    var body: some View {
        AsyncContentView(source: viewModel) { document in
            HTMLView(html: headerString + styleString + document.html)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Dokument \(documentId)")
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DocumentView(documentId: "H901FiU40")
            DocumentView(documentId: "H901FiU40")
                .preferredColorScheme(.dark)
        }
    }
}
