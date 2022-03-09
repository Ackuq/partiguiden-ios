//
//  CardButtonStyle.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-09.
//

import SwiftUI

struct CardButtonStyle: ButtonStyle {
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .background(backgroundColor)
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
        .opacity(configuration.isPressed ? 0.75 : 1)
    }
}

struct CardButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("This is")
                            .font(.subheadline)
                    }
                    HStack {
                        Text("a card view")
                            .font(.headline)
                            .bold()
                    }
                }
            }
            .buttonStyle(CardButtonStyle(backgroundColor: .accentColor))
            Button(action: {}) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("This is")
                            .font(.subheadline)
                    }
                    HStack {
                        Text("a card view")
                            .font(.headline)
                            .bold()
                    }
                }
            }
            .buttonStyle(CardButtonStyle(backgroundColor: .accentColor))
        }
    }
}
