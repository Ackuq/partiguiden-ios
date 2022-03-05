//
//  PartySubjectView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

import SwiftUI

struct PartyStandpointView: View {
    @State private var collapsed: Bool = false
    
    private var partyInfo: PartyInfo
    private var standpoint: Standpoint
    
    init(standpoint: Standpoint) {
        self.partyInfo = PartyManager.partyLetterDict[standpoint.party.uppercased()]!
        self.standpoint = standpoint
    }
    
    var body: some View {
        content
            .padding(.horizontal, 20)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            header
            if collapsed {
                Group {
                    ForEach(self.standpoint.content, id: \.self) { content in
                        HStack {
                            Rectangle().foregroundColor(partyInfo.color).frame(width: 10, height: 10).padding(.trailing, 5)
                            Text(content)
                            .fixedSize(horizontal: false, vertical: true)}
                        
                    }
                }
                .padding(.leading, 10)
            }
            Divider()
        }
    }
    
    private var header: some View {
        Button (
            action: {
                withAnimation(Animation.easeInOut) {
                    self.collapsed.toggle()
                }
            },
            label: {
                HStack {
                    Text(partyInfo.name)
                        .foregroundColor(partyInfo.color)
                        .font(.title3)
                    Spacer()
                    Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                        .foregroundColor(partyInfo.color)
                }
                .padding(.trailing, 10)
            }
        )
    }
}

struct PartyStandpointView_Previews: PreviewProvider {
    static var previews: some View {
        PartyStandpointView(standpoint: Standpoint(
            id: "asd",
            title: "Test",
            content: ["test content ajdsjsal  jalsjdlk j asdjkljakl j asldjlasj", "asdasd asd  asd"],
            date: "",
            link: "url",
            party: "S",
            subject: 1)
        )
    }
}
