//
//  CardButtonStyle.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-09.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct CardButtonStyle<Background>: ButtonStyle where Background: ShapeStyle {
    var backgroundColor: Background
    var foregroundColor: Color = .white
    var usePadding: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
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
            .buttonStyle(CardButtonStyle(backgroundColor: Color("AccentColor")))
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
            .buttonStyle(CardButtonStyle(backgroundColor: Color("AccentColor")))
        }
    }
}
