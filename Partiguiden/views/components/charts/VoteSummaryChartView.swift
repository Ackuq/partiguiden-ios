//
//  VoteSummaryChartView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-15.
//

import SwiftUI

struct VoteSummaryBarView: View {
    let id = UUID()
    
    var vote: String
    var color: Color
    var getWidth: (String) -> CGFloat
    @Binding var currentMarker: UUID?
    @State var showMarker = false
    
    var body: some View {
        if Int(vote)! > 0{
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: getWidth(vote), height: VoteSummaryChartView.height)
                    .onTapGesture {
                        if currentMarker == id {
                            currentMarker = nil
                        } else {
                            currentMarker = id
                        }
                    }
                if Int(vote)! > 7 && showMarker {
                    ChartMarkerView(content: vote, rotate: true)
                        .offset(x: 0, y: VoteSummaryChartView.height * 2)
                        .transition(.scale)
                        .zIndex(10)
                }
            }
            .frame(height: VoteSummaryChartView.height)
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
        } else {
            EmptyView()
        }
    }
}

struct VoteSummaryChartView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var currentMarker: UUID? = nil
    @State var animate: Bool = false
    
    var votes: VoteDescription
    var total: Double
    let width = UIScreen.main.bounds.width - CGFloat(16 * 2)
    
    init(votes: VoteDescription) {
        self.votes = votes
        self.total = Double(votes.yes)! + Double(votes.no)! + Double(votes.refrain)! + Double(votes.abscent)!
    }
    
    static var height: CGFloat = 20
    func getWidth(value: String) -> CGFloat {
        return CGFloat((Double(value)! / total)) * width
    }
    
    var body: some View {
        let voteColors = colorScheme == .light ? voteColorsLight : voteColorsDark
        
        VStack {
            ZStack(alignment: .trailing){
                HStack(spacing: 0) {
                    VoteSummaryBarView(
                        vote: votes.yes,
                        color: voteColors.yes,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.no,
                        color: voteColors.no,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.refrain,
                        color: voteColors.refrain,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.abscent,
                        color: voteColors.abscent,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                }
                Rectangle()
                    .frame(height: 20)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: animate ? 1 : width)
                    .animation(Animation.easeInOut(duration: 1), value: animate)
            }
            .padding(.bottom, 30)
            .onAppear { animate = true }
            
            HStack {
                HStack {
                    Rectangle()
                        .fill(voteColors.yes)
                        .frame(width: 10, height: 10)
                    Text("Ja")
                }
                HStack {
                    Rectangle()
                        .fill(voteColors.no)
                        .frame(width: 10, height: 10)
                    Text("Nej")
                }
                HStack {
                    Rectangle()
                        .fill(voteColors.refrain)
                        .frame(width: 10, height: 10)
                    Text("Avstående")
                }
                HStack {
                    Rectangle()
                        .fill(voteColors.abscent)
                        .frame(width: 10, height: 10)
                    Text("Frånvarande")
                }
            }
        }
    }
}

struct VoteSummaryChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteSummaryChartView(votes: VoteDescription(yes: "100", no: "7", refrain: "50", abscent: "99"))
            .preferredColorScheme(.dark)
    }
}
