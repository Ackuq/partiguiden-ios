//
//  SheetView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-09.
//

import SwiftUI

struct BaseSheetView<Content>: View where Content: View {
    var title: String
    @ViewBuilder var content: () -> Content

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        content()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Klar").bold()
            })
            .navigationTitle(title)
    }
}

struct SheetView<Content>: View where Content: View {
    var title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationView {
            BaseSheetView(title: title, content: content)
        }
    }
}
