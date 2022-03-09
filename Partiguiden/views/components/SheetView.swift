//
//  SheetView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-09.
//

import SwiftUI

struct SheetView<Content>: View where Content: View {
    var title: String
    @Binding var showingSheet: Bool
    @ViewBuilder var content: () -> Content

    init(title: String, showingSheet: Binding<Bool>, content: @escaping () -> Content) {
        self.title = title
        _showingSheet = showingSheet
        self.content = content
    }

    var body: some View {
        NavigationView {
            content()
                .navigationBarTitle(Text(title), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    showingSheet.toggle()
                }) {
                    Text("Klar").bold()
                })
        }
    }
}
