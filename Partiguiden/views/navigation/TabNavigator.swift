//
//  TabView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct TabNavigator: View {
    init() {
        UITabBar.appearance().tintColor = UIColor(named: "AccentColor")
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBackgroundColor")
    }

    var body: some View {
        TabView {
            SubjectsView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Ståndpunkter")
                }
            PartiesView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Partier")
                }
        }
    }
}

struct TabNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigator()
            .preferredColorScheme(.light)
        TabNavigator()
            .preferredColorScheme(.dark)
    }
}
