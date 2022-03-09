//
//  TabView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct TabNavigator: View {
    @State var selectedIndex = 0
    @State var showingDetailed = false

    var selectionBinding: Binding<Int> {
        Binding(
            get: {
                self.selectedIndex
            },
            set: {
                if $0 == self.selectedIndex {
                    // Should pop to root
                    showingDetailed = false
                }
                self.selectedIndex = $0
            }
        )
    }

    var body: some View {
        TabView(selection: selectionBinding) {
            SubjectsView(showingDetailed: $showingDetailed)
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Ståndpunkter")
                }
                .tag(0)

            PartiesView(showingDetailed: $showingDetailed)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Partier")
                }
                .tag(1)

            ParliamentDecisionsView()
                .tabItem {
                    Image(systemName: "checkmark.seal")
                    Text("Riksdagsbeslut")
                }
                .tag(2)
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
