//
//  PopableView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-14.
//

import SwiftUI

struct PopableView<Content>: View where Content: View {
    @EnvironmentObject var tabBarState: TabBarState
    @Environment(\.presentationMode) private var presentationMode
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .onChange(of: tabBarState.navToHome) { newValue in
                presentationMode.wrappedValue.dismiss()
            }
    }
}
