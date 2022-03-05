//
//  StandpointsView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct StandpointsView: View {
    var id: Int
    var name: String
    
    @State var subject: Subject? = nil
    
    var body: some View {
        NavigationView{
            if subject != nil {
                ScrollView{
                    ForEach(subject!.standpoints) { standpoint in
                        PartyStandpointView(standpoint: standpoint)
                    }}
            } else {
                LoadingView()
            }
        }
        .navigationTitle(name)
        .onAppear(perform: {
            ApiManager.shared.getSubject(
                endpoint: EndpointCases.getSubject(id: id)) { subject in
                    self.subject = subject
                }
        })
    }
}

struct StandpointsView_Previews: PreviewProvider {
    static var previews: some View {
        StandpointsView(id: 2, name: "Test")
    }
}
