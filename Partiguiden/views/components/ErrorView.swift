//
//  ErrorView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-12.
//

import SwiftUI

struct ErrorView: View {
    @State private var showingAlert = true
    var error: Error

    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            Text("Ojdå, något gick fel, försök att starta om appen.")
                .font(.headline)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Ett fel uppstod"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: URLError(URLError.Code.badURL))
    }
}
