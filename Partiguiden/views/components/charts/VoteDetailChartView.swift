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
                        .transition(.scale)
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
    var votes: VoteDescription
    var party: PartyInfo
    let voteColors: VoteColor
    
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
                    .frame(
                        width: animate ? 1 : PartyVoteDetailView.getWidth(value: String(total)),
                        height: PartyVoteDetailView.height
                    )
                    .foregroundColor(Color(UIColor.systemBackground))
                    .animation(Animation.easeInOut(duration: 1), value: animate)
            }
        }
        .onAppear { animate = true }
        
    }
}

struct VoteDetailChartView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var currentMarker: UUID? = nil
    var voting: VotingParticipants
    
    
    var body: some View {
        let voteColors = colorScheme == .light ? voteColorsLight : voteColorsDark
        
        LazyVStack(alignment: .leading) {
            PartyVoteDetailView(
                votes: voting.S,
                party: PartyManager.parties[PartyKey.S]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.M,
                party: PartyManager.parties[PartyKey.M]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.SD,
                party: PartyManager.parties[PartyKey.SD]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.C,
                party: PartyManager.parties[PartyKey.C]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.V,
                party: PartyManager.parties[PartyKey.V]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.KD,
                party: PartyManager.parties[PartyKey.KD]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.L,
                party: PartyManager.parties[PartyKey.L]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
            PartyVoteDetailView(
                votes: voting.MP,
                party: PartyManager.parties[PartyKey.MP]!,
                voteColors: voteColors,
                currentMarker: $currentMarker
            )
        }
    }
}

struct VoteDetailChartView_Previews: PreviewProvider {
    static let voteDescription = VoteDescription(yes: "3", no: "4", refrain: "10", abscent: "10")
    
    static let votingParticipants = VotingParticipants(
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
