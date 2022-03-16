//
//  TabView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

class TabBarState: ObservableObject {
    @Published var navToHome = false
    @Published var _selectedTab = 0
}

struct TabNavigator: View {
    @StateObject var tabBarState = TabBarState()
    
    var body: some View {
        let selectedTab = Binding(
            get: { tabBarState._selectedTab },
            set: {
                if $0 == tabBarState._selectedTab {
                    tabBarState.navToHome.toggle()
                }
                tabBarState._selectedTab = $0
            }
        )
        
        TabView (selection: selectedTab) {
            SubjectsView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Ståndpunkter")
                }
                .tag(0)

            PartiesView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Partier")
                }
                .tag(1)

            DecisionsView()
                .tabItem {
                    Image(systemName: "checkmark.seal")
                    Text("Riksdagsbeslut")
                }
                .tag(2)
            VotesView()
                .tabItem {
                    Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                    Text("Voteringar")
                }
                .tag(3)
        }
        .environmentObject(tabBarState)
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
