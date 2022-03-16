//
//  SheetView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-09.
//

import SwiftUI


struct SheetView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Klar").bold()
                })
        }
    }
}
