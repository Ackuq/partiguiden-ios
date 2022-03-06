//
//  LoadingView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-06.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Laddar...")
            .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
            .foregroundColor(Color("AccentColor"))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
