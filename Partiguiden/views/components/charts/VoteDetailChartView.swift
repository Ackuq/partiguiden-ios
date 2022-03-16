//
//  VoteDetailChartView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-16.
//

import SwiftUI


struct PartyVoteBar: View {
    let id = UUID()
    
    var vote: String
    var color: Color
    @Binding var currentMarker: UUID?
    @State var showMarker = false
    
    
    var body: some View {
        if Int(vote)! > 0 {
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: PartyVoteDetailView.getWidth(value: vote), height: PartyVoteDetailView.height)
                    .onTapGesture {
                        if currentMarker == id {
                            currentMarker = nil
                        } else {
                            currentMarker = id
                        }
                    }
                if Int(vote)! > 3 && showMarker {
                    ChartMarkerView(content: vote)
                        .offset(x: 0, y: (-PartyVoteDetailView.height / 2) + 5)
                        .zIndex(10)
                }
            }
            .frame(height: PartyVoteDetailView.height)
            .onChange(of: currentMarker) { newValue in
                if newValue != id && showMarker {
                    withAnimation {
                        showMarker = false
                    }
                } else if (newValue == id && !showMarker) {
                    withAnimation {
                        showMarker = true
                    }
                }
            }
        }
        else {
            EmptyView()
        }
    }
}

struct PartyVoteDetailView: View {
    var votes: VoteDescriptionResponse
    var party: PartyData
    
    @Binding var currentMarker: UUID?
    @State var animate = false
    
    static let height: CGFloat = 30
    static func getWidth(value: String) -> CGFloat {
        return CGFloat(Double(value)!) * 3
    }
    
    
    var body: some View {
        let total = [votes.yes, votes.no, votes.refrain, votes.abscent].map { Int($0)! }.reduce(0, { $0 + $1 })
        HStack(spacing: 0) {
            party.image
                .resizable()
                .frame(width: PartyVoteDetailView.height, height: PartyVoteDetailView.height)
                .padding(.trailing, 10)
            ZStack(alignment: .trailing) {
                HStack(spacing: 0){
                    PartyVoteBar(vote: votes.yes, color: voteColors.yes, currentMarker: $currentMarker)
                    PartyVoteBar(vote: votes.no, color: voteColors.no, currentMarker: $currentMarker)
                    PartyVoteBar(vote: votes.refrain, color: voteColors.refrain, currentMarker: $currentMarker)
                    PartyVoteBar(vote: votes.abscent, color: voteColors.abscent, currentMarker: $currentMarker)
                }
                Rectangle()
                    .frame(height: PartyVoteDetailView.height)
                    .frame(
                        width: animate ? 1 : PartyVoteDetailView.getWidth(value: String(total))
                    )
                    .foregroundColor(Color(UIColor.systemBackground))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animate = true
            }
        }
        
    }
}

struct VoteDetailChartView: View {
    @State var currentMarker: UUID? = nil
    var voting: VotingParticipantsResponse
    
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            PartyVoteDetailView(
                votes: voting.S,
                party: Party.S.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.M,
                party: Party.M.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.SD,
                party: Party.SD.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.C,
                party: Party.C.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.V,
                party: Party.V.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.KD,
                party: Party.KD.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.L,
                party: Party.L.data,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.MP,
                party: Party.MP.data,
                currentMarker: $currentMarker
            )
            HStack {
                Spacer()
                ColorDescriptionView()
                Spacer()
            }
        }
    }
}

struct VoteDetailChartView_Previews: PreviewProvider {
    static let voteDescription = VoteDescriptionResponse(yes: "3", no: "4", refrain: "10", abscent: "10")
    
    static let votingParticipants = VotingParticipantsResponse(
        total: voteDescription,
        noParty: voteDescription,
        S: voteDescription,
        M: voteDescription,
        SD: voteDescription,
        C: voteDescription,
        V: voteDescription,
        KD: voteDescription,
        L: voteDescription,
        MP: voteDescription
    )
    
    static var previews: some View {
        VoteDetailChartView(voting: votingParticipants)
    }
}
