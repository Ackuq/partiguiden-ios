//
//  PartySubjectView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-04.
//

import SwiftUI

struct PartyStandpointView: View {
    @State var showingSheet = false

    private var partyInfo: PartyInfo
    private var standpoints: [Standpoint]

    init(party: String, standpoints: [Standpoint]) {
        partyInfo = partyLetterDict[party.uppercased()]!
        self.standpoints = standpoints
    }

    var body: some View {
        Button(action: {
            showingSheet.toggle()
        }) {
            Text(partyInfo.name)
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(partyInfo.color)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .sheet(isPresented: $showingSheet) {
            SheetView(title: partyInfo.name, showingSheet: $showingSheet) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.standpoints) { standpoint in
                            Text(standpoint.title)
                                .font(.headline)
                            ForEach(standpoint.content, id: \.self) { content in
                                HStack(alignment: .top) {
                                    Rectangle().foregroundColor(partyInfo.color).frame(width: 10, height: 10).padding(.vertical, 7.5)
                                    Text(content)
                                }
                            }
                            Link("Läs mer på partiets hemsida", destination: URL(string: standpoint.link)!)
                                .foregroundColor(partyInfo.color)
                            if standpoint.id != standpoints.last?.id {
                                Divider()
                            }
                        }
                    }.padding()
                }
            }
        }
    }
}

struct PartyStandpointView_Previews: PreviewProvider {
    static var previews: some View {
        PartyStandpointView(party: "S", standpoints:
            [
                Standpoint(
                    id: "asd",
                    title: "Test",
                    content: ["test content ajdsjsal  jalsjdlk j asdjkljakl j asldjlasj", "asdasd asd  asd"],
                    date: "",
                    link: "url",
                    party: "S",
                    subject: 1
                ),
                Standpoint(
                    id: "asd2",
                    title: "Test2",
                    content: ["test content2 ajdsjsal  jalsjdlk j asdjkljakl j asldjlasj", "asdasd asd  asd"],
                    date: "",
                    link: "url",
                    party: "S",
                    subject: 1
                ),
            ])
    }
}
